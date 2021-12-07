use specs::prelude::*;

use rltk::{Rltk, GameState, RGB};

mod map;
mod player;
mod component;
mod visibility_system;
mod rect;
mod monster_ai_system;

pub use component::*;
pub use map::*;
pub use player::*;
pub use rect::Rect;
use visibility_system::VisibilitySystem;
use crate::monster_ai_system::MonsterAI;


pub struct State {
    pub ecs: World,
}


impl State {
    fn run_system(&mut self) {
        let mut vis = VisibilitySystem {};
        vis.run_now(&self.ecs);
        let mut mob = MonsterAI{};
        mob.run_now(&self.ecs);
        self.ecs.maintain();
    }
}


impl GameState for State {
    fn tick(&mut self, ctx: &mut Rltk) {
        ctx.cls();

        player_input(self, ctx);
        self.run_system();

        draw_map(&self.ecs, ctx);

        let positions = self.ecs.read_storage::<Position>();
        let renderables = self.ecs.read_storage::<Renderable>();
        let map = self.ecs.fetch::<Map>();

        for (pos, render) in (&positions, &renderables).join() {
            let idx = map.xy_idx(pos.x, pos.y);
            if map.visible_tiles[idx] {
                ctx.set(pos.x, pos.y, render.fg, render.bg, render.glyph);
            }
        }
    }
}


fn main() -> rltk::BError {
    use rltk::RltkBuilder;
    let context = RltkBuilder::simple80x50().with_title("Roguelike Tutorial").build()?;

    let mut gs = State { ecs: World::new() };

    gs.ecs.register::<Position>();
    gs.ecs.register::<Renderable>();
    gs.ecs.register::<Player>();
    gs.ecs.register::<Viewshed>();
    gs.ecs.register::<Monster>();


    let (rooms, map) = new_map_rooms_and_corridors();
    gs.ecs.insert(map);
    let (player_x, player_y) = rooms[0].center();


    gs.ecs.create_entity().with(Position { x: player_x, y: player_y })
        .with(Renderable {
            glyph: rltk::to_cp437('@'),
            fg: RGB::named(rltk::YELLOW),
            bg: RGB::named(rltk::BLACK),
        }).with(Player {}).with(Viewshed { visible_tiles: Vec::new(), range: 8, dirty: true }).build();

    let mut rng = rltk::RandomNumberGenerator::new();

    for room in map.rooms.iter().skip(1) {
        let (x, y) = room.center();
        let glyph_r: rltk::FontCharType;
        let roll = rng.roll_dice(1, 2);
        match roll {
            1 => { glyph_r = rltk::to_cp437('g') }
            _ => { glyph_r = rltk::to_cp437('o') }
        }
        gs.ecs.create_entity()
            .with(Position { x, y })
            .with(Renderable {
                glyph: glyph_r,
                fg: RGB::named(rltk::RED),
                bg: RGB::named(rltk::BLACK),
            }).with(Viewshed {
            visible_tiles: Vec::new(),
            range: 8,
            dirty: true,
        }).with(Monster {}).build();
    }
    gs.ecs.insert(map);

    rltk::main_loop(context, gs)
}

