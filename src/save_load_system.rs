use std::fs::File;
use std::path::Path;
use std::fs;
use specs::error::NoError;
use specs::prelude::*;
use specs::saveload::{MarkedBuilder, SimpleMarker, SimpleMarkerAllocator, SerializeComponents, DeserializeComponents};
use super::component::*;
use super::map::{Map, MAP_COUNT};

macro_rules! serialize_individually {
    ($ecs: expr, $ser: expr, $data: expr, $($type: ty), *) => {
        $(SerializeComponents::<NoError, SimpleMarker<SerializeMe>>::serialize(
            &($ecs.read_storage::<$type>(), ),
            &$data.0,
            &$data.1,
            &mut $ser,).unwrap(); )*
    };
}

macro_rules! deserialize_individually {
    ($ecs: expr, $de: expr, $data: expr, $($type: ty), *) => {
        $(DeserializeComponents::<NoError, _>::deserialize(
            &mut (&mut $ecs.write_storage::<$type>(), ),
            &$data.0,      // entities
            &mut $data.1,  // marker
            &mut $data.2,  // allocater
            &mut $de,
        ).unwrap(); )*
    };
}

#[cfg(not(target_arch = "wasm32"))]
pub fn save_game(ecs: &mut World) {
    // Create helper
    let map_copy = ecs.get_mut::<Map>().unwrap().clone();

    let save_helper = ecs
        .create_entity()
        .with(SerializationHelper { map: map_copy })
        .marked::<SimpleMarker<SerializeMe>>()
        .build();

    // Actually serialize
    {
        let data = (ecs.entities(), ecs.read_storage::<SimpleMarker<SerializeMe>>());

        let writer = File::create("./save_game.json").unwrap();
        let mut serializer = serde_json::Serializer::new(writer);

        serialize_individually!(ecs, serializer, data, Position, Renderable, Player, Viewshed,
            Monster, Name , BlocksTile, CombatStats, SufferDamage, WantsToMelee, Item,
            Consumable, Ranged, InflictsDamage, AreaOfEffect, Confusion, ProvidesHealing,
            InBackPack, WantsToPickupItem, WantsToUseItem, WantsToDropItem, SerializationHelper, Equippable, Equipped);
    }

    // Clean up
    ecs.delete_entity(save_helper).expect("Crash on cleanup");
}

#[cfg(target_arch = "wasm32")]
pub fn save_game(_ecs: &mut World) {}

pub fn does_save_exist() -> bool {
    Path::new("./save_game.json").exists()
}

pub fn load_game(ecs: &mut World) {
    {
        // Delete everything
        let mut to_delete = Vec::new();
        for e in ecs.entities().join() {
            to_delete.push(e);
        }
        for del in to_delete.iter() {
            ecs.delete_entity(*del)
                .expect("Deletion failed");
        }
    }

    let data = fs::read_to_string("./save_game.json").unwrap();
    let mut de = serde_json::Deserializer::from_str(&data);
    {
        let mut d = (&mut ecs.entities(),
                     &mut ecs.write_storage::<SimpleMarker<SerializeMe>>(),
                     &mut ecs.write_resource::<SimpleMarkerAllocator<SerializeMe>>());

        deserialize_individually!(ecs, de, d, Position, Renderable, Player,
                Viewshed, Monster, Name, BlocksTile, CombatStats, SufferDamage, WantsToMelee, Item, Consumable,
                Ranged, InflictsDamage, AreaOfEffect, Confusion, ProvidesHealing, InBackPack, WantsToPickupItem,
                WantsToUseItem, WantsToDropItem, SerializationHelper, Equippable, Equipped);
    }

    let mut deleteme: Option<Entity> = None;
    {
        let entities = ecs.entities();
        let helper = ecs.read_storage::<SerializationHelper>();
        let player = ecs.read_storage::<Player>();
        let position = ecs.read_storage::<Position>();

        for (e, h) in (&entities, &helper).join() {
            let mut worldmap = ecs.write_resource::<Map>();
            *worldmap = h.map.clone();
            worldmap.tile_content = vec![Vec::new(); MAP_COUNT];
            deleteme = Some(e);
        }
        for (e, _p, pos) in (&entities, &player, &position).join() {
            let mut ppos = ecs.write_resource::<rltk::Point>();
            *ppos = rltk::Point::new(pos.x, pos.y);
            let mut player_resource = ecs.write_resource::<Entity>();
            *player_resource = e;
        }
    }
    ecs.delete_entity(deleteme.unwrap()).expect("Unable to delete helper");
}

pub fn delete_save() {
    if Path::new("./save_game.json").exists() {
        fs::remove_file("./save_game.json").expect("Unable to delete file");
    }
}

