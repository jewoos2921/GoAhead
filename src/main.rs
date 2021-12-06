use rltk::{Rltk, GameState, RGB};
use std::cmp::{max, min};
use specs::prelude::*;
use specs_derive::Component;

struct State {
    ecs: World,
}

#[derive(Component)]
struct Position {
    x: i32,
    y: i32,
}

#[derive(Component)]
struct Renderable {
    glyph: rltk::FontCharType,
    fg: RGB,
    bg: RGB,
}


impl Component for Position {
    type Storage = VecStorage<Self>,
}


impl GameState for State {
    fn tick(&mut self, ctx: &mut Rltk) {
        ctx.cls();
        ctx.print(1, 1, "Hello Rust World");
    }
}


fn main() -> rltk::BError {
    use rltk::RltkBuilder;
    let context = RltkBuilder::simple80x50().with_title("Roguelike Tutorial").build()?;
    let mut gs = State { ecs: World::new() };
    gs.ecs.register::<Position>();
    gs.ecs.register::<Renderable>();
    rltk::main_loop(context, gs)
}

