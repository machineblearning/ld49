# Design Doc

## Description

A side-scrolling platformer where the player is escaping an *unstable* crumbling tower. As the player traverses down the tower they must evade falling debris. The player chacter can move left and right but they cannot jump. They will fall after walking over the edge of a platform. While free-falling the player can hold a button to glide, which slows down their decent and gives them better air movement control. Using the glide makes it easier to avoid debris that is falling from above. The player can also dodge while in the air to avoid debris. Both gliding and dodging consume stamina so the player must use them wisely. Stamina is regained while standing on a platform. The player has three hearts, losing one each time they get hit by debris. The game ends if the player reaches zero hearts. The player can collect hats which act like armor, protecting the player if they get hit by debris. The hats act like extra hearts. The player can have up to three hats on at one time (essentially six hearts max).

## Entities

Player
    - gives info to UI
    - collides w/ Platforms
    - collides w/ PowerUps
    - collids w/ Debris
    - collides w/ Level Triggers

Platforms

Hat
    - attached to Player
    - collides w/ Debris

Debris
    - collides w/ Player
    - collides w/ Hat

PowerUp
    - collides w/ Player

UI - Hearts

UI - Armor (Hat)

UI - Stamina

Level Trigger - checkpoint
    - collides w/ Player

Level Trigger - level end
    - collides w/ Player


## Player States

Idle

Walking

Falling

Gliding

Dodging

Hitstun