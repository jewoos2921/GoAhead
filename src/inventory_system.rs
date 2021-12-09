use specs::prelude::*;
use crate::{Map, SufferDamage};
use super::{WantsToPickupItem, Name, InBackPack, Position, GameLog, CombatStats,
            WantsToDrinkPotion, ProvidesHealing, WantsToDropItem, Consumable};

pub struct ItemCollectionSystem {}

impl<'a> System<'a> for ItemCollectionSystem {
    #[allow(clippy::type_complexity)]
    type SystemData = (
        ReadExpect<'a, Entity>,
        WriteExpect<'a, GameLog>,
        WriteStorage<'a, WantsToPickupItem>,
        WriteStorage<'a, Position>,
        ReadStorage<'a, Name>,
        WriteStorage<'a, InBackPack>
    );

    fn run(&mut self, data: Self::SystemData) {
        let (player_entity,
            mut gamelog,
            mut wants_pickup,
            mut positions,
            names,
            mut backpack) = data;

        for pickup in wants_pickup.join() {
            positions.remove(pickup.item);
            backpack.insert(pickup.item,
                            InBackPack { owner: pickup.collected_by }).expect("Unable to insert backpack entry");

            if pickup.collected_by == *player_entity {
                gamelog.entries.push(format!("You pick up the {}.",
                                             names.get(pickup.item).unwrap().name));
            }
        }

        wants_pickup.clear();
    }
}

pub struct ItemUseSystem {}

impl<'a> System<'a> for ItemUseSystem {
    #[allow(clippy::type_complexity)]
    type SystemData = (
        ReadExpect<'a, Entity>,
        WriteExpect<'a, GameLog>,
        ReadExpect<'a, Map>,
        Entities<'a>,
        WriteStorage<'a, WantsToDrinkPotion>,
        ReadStorage<'a, Name>,
        ReadStorage<'a, ProvidesHealing>,
        WriteStorage<'a, CombatStats>
    );

    fn run(&mut self, data: Self::SystemData) {
        let (player_entity,
            mut gamelog,
            entities,
            mut wants_drink,
            names,
            healing,
            mut combat_stats) = data;

        for (entity, drink, stats) in (&entities, &wants_drink, &mut combat_stats).join() {
            let consumable = consumables.get(useitem.item);
            match consumable {
                None => {}
                Some(_) => {
                    entities.delete(useitem.item).expect("Delete failed");
                }
            }


            let item_heals = healing.get(usitem.item);
            match item_heals {
                None => {}
                Some(healer) => {
                    stats.hp = i32::min(stats.max_hp, stats.hp + healer.heal_amount);
                    if entity == *player_entity {
                        gamelog.entries.push(format!("You drink the {}, healing {} hp.",
                                                     names.get(usetime.item).unwrap().name, healer.heal_amount));
                    }
                }
            }

            // If it inflicts damage, apply it to the target cell
            let item_damages = inflicit_damage.get(useitem.item);
            match item_damages {
                None =>{}
                Some(damage) =>{
                    let target_point = useitem.target.unwrap();
                    let idx = map.xy_idx(target_point.x, target_point.y);
                    used_item = false;
                    for mob in map.tile_content[idx].iter() {
                        SufferDamage::new_damage(&mut suffer_damage, *mob, damage.damage);
                        if entity == *player_entity{
                            let mob_name = names.get(*mob).unwrap();

                            let item_name = names.get(useitem.item).unwrap();
                            gamelog.entries.push(format!("You use {} on {}, inflicting {} hp.",
                                                         item_name.name, mob_name.name, damage.damage));
                        }
                        used_item = true;
                    }
                }
            }
        }
        wants_drink.clear();
    }
}

pub struct ItemDropSystem {}

impl<'a> System<'a> for ItemDropSystem {
    #[allow(clippy::type_complexity)]
    type SystemData = (ReadExpect<'a, Entity>,
                       WriteExpect<'a, GameLog>,
                       Entities<'a>,
                       WriteStorage<'a, WantsToDropItem>,
                       ReadStorage<'a, Name>,
                       WriteStorage<'a, Position>,
                       WriteStorage<'a, InBackPack>);

    fn run(&mut self, data: Self::SystemData) {
        let (player_entity,
            mut gamelog,
            entities,
            mut wants_drop,
            names,
            mut positions,
            mut backpack) = data;

        for (entity, to_drop) in (&entities, &wants_drop).join() {
            let mut dropper_pos: Position = Position { x: 0, y: 0 };
            {
                let dropped_pos = positions.get(entity).unwrap();
                dropper_pos.x = dropped_pos.x;
                dropper_pos.y = dropped_pos.y;
            }
            positions.insert(to_drop.item,
                             Position { x: dropper_pos.x, y: dropper_pos.y }).expect("Unable to insert position");
            backpack.remove(to_drop.item);

            if entity == *player_entity {
                gamelog.entries.push(format!("You drop the {}.", names.get(to_drop.item).unwrap().name));
            }
        }

        wants_drop.clear();
    }
}