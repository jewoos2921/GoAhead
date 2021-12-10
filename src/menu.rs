use rltk::{RGB, Rltk, VirtualKeyCode};
use crate::gui::{MainMenuResult, MainMenuSelection};
use crate::{RunState, State};

pub fn main_menu(gs: &mut State, ctx: &mut Rltk) -> MainMenuResult {
    let run_state = gs.ecs.fetch::<RunState>();
    ctx.print_color_centered(15, RGB::named(rltk::YELLOW), RGB::named(rltk::BLACK), "Rust Roguelike Tutorial");

    if let RunState::MainMenu { menu_selection: selection } = *run_state {
        if selection == MainMenuSelection::NewGame {
            ctx.print_color_centered(24, RGB::named(rltk::MAGENTA), RGB::named(rltk::BLACK),
                                     "Begin New Game");
        } else {
            ctx.print_color_centered(24, RGB::named(rltk::WHITE), RGB::named(rltk::BLACK),
                                     "Begin New Game");
        }

        if selection == MainMenuSelection::LoadGame {
            ctx.print_color_centered(25, RGB::named(rltk::MAGENTA), RGB::named(rltk::BLACK),
                                     "Load Game");
        } else {
            ctx.print_color_centered(25, RGB::named(rltk::WHITE), RGB::named(rltk::BLACK),
                                     "Load Game");
        }

        if selection == MainMenuSelection::Quit {
            ctx.print_color_centered(26, RGB::named(rltk::MAGENTA), RGB::named(rltk::BLACK),
                                     "Quit");
        } else {
            ctx.print_color_centered(26, RGB::named(rltk::WHITE), RGB::named(rltk::BLACK),
                                     "Quit");
        }
        match ctx.key {
            None => return MainMenuResult::NoSelection { selected: selection },
            Some(key) => {
                match key {
                    VirtualKeyCode::Escape => { return MainMenuResult::NoSelection { selected: MainMenuSelection::Quit }; }
                    VirtualKeyCode::Up => {
                        let new_selection;
                        match selection {
                            MainMenuSelection::NewGame => new_selection = MainMenuSelection::Quit,
                            MainMenuSelection::LoadGame => new_selection = MainMenuSelection::NewGame,
                            MainMenuSelection::Quit => new_selection = MainMenuSelection::LoadGame
                        }
                        return MainMenuResult::NoSelection { selected: new_selection };
                    }
                    VirtualKeyCode::Down => {
                        let new_selection;
                        match selection {
                            MainMenuSelection::NewGame => new_selection = MainMenuSelection::LoadGame,
                            MainMenuSelection::LoadGame => new_selection = MainMenuSelection::Quit,
                            MainMenuSelection::Quit => new_selection = MainMenuSelection::NewGame
                        }
                        return MainMenuResult::NoSelection { selected: new_selection };
                    }
                    VirtualKeyCode::Return => return MainMenuResult::Selected { selected: selection },
                    _ => return MainMenuResult::NoSelection { selected: selection }
                }
            }
        }
    }
    MainMenuResult::NoSelection { selected: MainMenuSelection::NewGame }
}