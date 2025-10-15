---
layout: post
title: "Physics in Games: A Quick Study"
description: "Physics is really important for games. In this article we'll explore how games simulate physics and the inner workings of one of the common physics engines: Box2D"
date: 2025-10-13
feature_image: images/2025-10-13-physics/ragdoll.webp
tags: [software, programming, games]
author: mamede
---

Physics is really important for games. In this article we'll explore how games simulate physics and the inner
workings of one of the common physics engines: Box2D

<!--more-->

## Before Physics Engines

Before there were fully fledged physics systems implemented inside games, each effect had its own implementation.
If a game required, for instance, the player to move a box, the box movement and its response to
the player's input were programmed for that interaction only, not taking other systems into consideration.

Take for example, the first Super Mario Bros., the jump mechanic had hardcoded values for its initial impulse and
vertical speed and acceleration, Mario was different from the Goombas in the scene in a physical sense. This is
really good enough for most games, especially ones involving precision and tight player movement, sometimes less
accurate physics leads to more responsive gameplay.

But a great number of games require dealing with simulated physics worlds, Half-Life 2 and The Legend of Zelda:
Breath of the Wild are examples of games built entirely around physics simulations and object interactions.
In these kinds of games, you might want to throw a rock at an enemy and you expect not only the enemy to
react accordingly, but the rock to follow a realistic trajectory, fall down and maybe push with other
objects in its way.

And there are so many fun and interesting emergent behaviors deriving from that system. In the Breath of the Wild,
it's possible to freeze time, hit a tree, climb it, unfreeze time and be launched miles away while attached to
the tree. I don't know if this was really intended by the developers, but it certainly is fun!
It's not a matter of just throwing the rock and calculating its trajectory anymore, the rock and everything
around it are part of a big simulated world.

{% include image_caption.html imageurl="images/2025-10-13-physics/stasis-launch.png" title="Stasis Launch"
caption="Technique in The Legend of Zelda: Breath of the Wild called stasis launch" %}

How developers do this? You might ask. Lots and lots of Maths, clever optimizations and, of course, Physics.
For easier understanding, this article will be divided in three parts, I'll talk about how real-time
games operate, how objects on screen relate to objects in the physics world and, lastly, a bit about
Physics and those fancy maths I talked about.

## Real-time games under the hood

A real-time game operates a bit differently, whereas turn-based or board games only need to update their state
when the player makes a move or some effect triggers, real-time games update with every *tick*.

A tick is basically an event happening a bunch of times per second, every time a tick happens, it tells all
the objects in the scene to call their update function, this function is what makes an object, say, move or rotate.

In simpler engines, the tick function can be tied directly with the draw function, whenever the objects
change, redraw them on-screen, this however can be a bit inefficient, most commercial game engines today like
to separate these functions and make them update independently of one another, a game can have a draw tick
for draw events, an update tick for in-game logic and a physics tick for simulating physics.

Separating the ticks allows for better use of system resources, less resource intensive computations, like
updating the score, can be placed in the update tick, allowing them to trigger hundreds of times per second.
Expensive computations, like drawing to the screen, can be offloaded to the GPU and happen independently
from the other computations. And the physics ticks can be made to run on fixed intervals (this is Unity's `FixedUpdate()`), this is useful
because physics calculations are more stable when the time interval doesn't vary.

## What is shown on-screen vs what is happening

By now you have probably guessed that the objects on-screen don't exactly translate to the data being
processed under the hood, and you would be correct. Since this article is about physics I'm only going
to talk about the physics objects' relationship with on-screen objects, but you can easily extrapolate
this to every other part of the game.

As far as 25 years ago, character models already used hundreds of polygons (Spyro from PS1 had 500-600 triangles)
this number today is already in the hundreds of thousands! Far too much to handle physics calculations happening
60 times per second for one object, let alone hundreds that may be shown on-screen. That's why games cheat:
they use simpler models (the collision shape) for simulation and leave the big, high-polygon-count models only for
rendering.

Some games actually allow you to use debug features and see what's going on with the colliders, when you turn
this feature on, you might be surprised by how simple these interactions really are, many games get away with
using only boxes for every physics interaction. Most games, however, support a great variety of shapes, like
spheres, boxes, capsules and convex hulls.

{% include image_caption.html imageurl="images/2025-10-13-physics/hitboxes.webp" title="Hitboxes Elden Ring" caption="Even modern AAA games like Elden Ring prefer to use simple shapes for collision because they are more performant and the player won't notice" %}

What you see with these collision shapes are the game itself (maybe not really since most games like to interpolate
the objects between physics frames for smoother motion but you get the point)! All the fancy graphics and physics effects
are just objects that follow these collision shape's position, so if the player's collision box move forward, the
player model should be rendered at that position. The player model should be responsible from rendering
its own graphics and animations.

## The Physics

Now we're gonna talk about the nitty-gritty stuff, this article should be good for anyone but I'm gonna assume
you are familiar with a bit of math, especially linear algebra and trigonometry. If you're not familiar with
vectors I recommend reading a book on that stuff because it's good to know. Also, I'm going to be using code
references from the [Box2D Documentation](https://box2d.org/documentation/index.html), Box2D is, as they describe it,
"a 2D rigid body simulation library for games" written in portable C17, but even if you don't know C you should be fine.
Also, I'm not gonna talk about actual physics here, we're gonna stop at collision detection, if you want to know
more I recommend reading a good book on [Classical Mechanics](https://en.wikipedia.org/wiki/Classical_mechanics)

Most games have a physics world running alongside with the game world, what this means is that everything that
should interact with physics objects should have a shape registered in a physics world. Let's say you have a 2D game
with a player character and a box they should move: for this example, the player will have a capsule circle shape
and the box has a box shape.

A circle in 2d space can be defined with a 2D vector and a radius:

```c
// Box2D: collision.h (line 104)
typedef struct b2Circle
{
    b2Vec2 center;
    float radius;
} b2Circle;
```

A box in 2d space can be defined with a 2d vector for its center, a width and a height, Box2D doesn't have a structure
for boxes, it uses polygons instead, but that's ok, since a box is just a polygon with 4 vertices. There's a helper
function for creating boxes called [b2MakeBox](https://github.com/erincatto/box2d/blob/cfa9ef1b76256f92ec3e26a1a20521e50dddac19/src/geometry.c#L138):

```c
// Box2D: collision.h (line 133)
typedef struct b2Polygon
{
    b2Vec2 vertices[B2_MAX_POLYGON_VERTICES];
    b2Vec2 normals[B2_MAX_POLYGON_VERTICES];
    b2Vec2 centroid;
    float radius;
    int count;
} b2Polygon;

// (line 201)
B2_API b2Polygon b2MakeBox( float halfWidth, float halfHeight );
```

Alright, now we've defined the shapes we need, next step is defining how they should behave.
This is the what we defined:

{% include image_caption.html imageurl="images/2025-10-13-physics/objects.png" title="Physics world" caption="The player circle and a box in the physics world" %}

For both of these objects, they should be rigid bodies - meaning they should not
deform, should be affected by gravity, have mass and cannot overlap other bodies -
In the real world, all rigid bodies are dynamic, which means they all have mass and are susceptible to *forces*,
but in games we also have static and kinematic rigid bodies:

- Static bodies cannot move and are not affected by gravity.
- Kinematic bodies behave like bodies with *infinite mass*, they cannot be accelerated by *forces* and can only
move via code

Let's now say the player is moving towards the box, at a constant horizontal speed X, the player's velocity is a vector
that will determine the change in position with respect to time, in the next frame, the player will
collide with the box.

{% include image_caption.html imageurl="images/2025-10-13-physics/object-movement.png" title="Object movement" caption="Player is moving towards the box" %}

If we call the player's current position `P`, and the velocity `V`, we can say that the player's next position is
`P + V`, simple right? But remember, the physics engine moves in ticks, if we say that the `P` is in meters and `V`
in meters per second, then we expect that `P + V` should happen in the span of a second. This is an easy solve,
if the tickrate is 60 ticks per second, we can invert that and know that `1 tick = 1/60 seconds`, we call this *Time Delta*
or `Δt`. Then, we can just multiply this by the velocity having the next position to be `P + V * Δt`.
This is the reason physics ticks like to run in fixed intervals (usually 60 per second), we could use the `Δt`
to get this tickrate interval but having fixed intervals helps stabilize the movement.

### The player collided with the box. Now what?

First the computer needs to know that the player really collided with the box, because we are human,
we can easily see that they are in fact intersecting, and we are inferring this based on our
observation, but if I give you the data: `Player { position = (2,5), radius = 1}` and
`Box { position = (3, 5), width = 1, height = 1 }` then it becomes more difficult, doesn't it? That's what
the computer knows, it doesn't have those fancy eyes like we do, we need to find out how to
know these objects collide using only numbers.

For circle-to-circle collision, it's easy, we just need to check if the distance between their centers `d` is
smaller than the sum of their radii `r1 + r2`, if you look at the picture you can see why:

> You can calculate distances using `d = sqrt(x²+y²)`, computers however have been historically bad at calculating
> square roots, one common optimization is comparing the squared lengths instead of the actual lengths.

{% include image_caption.html imageurl="images/2025-10-13-physics/circle-collision.png" title="circle collision" caption="Circle collision" %}

Axis-aligned box-to-box collision is also very straightforward and I'll leave it as an exercise to the reader. For our example, we
actually need *box-to-circle* collision. And if you're wondering: yes, we use custom functions for each pair of colliders
we support.

As I said previously, Box2D treats boxes as polygons, so instead of box-to-circle, it uses a function called
[b2CollidePolygonAndCircle](https://github.com/erincatto/box2d/blob/cfa9ef1b76256f92ec3e26a1a20521e50dddac19/src/manifold.c#L141)
I'll leave a link here but I'll explain its implementation. If you want to implement actual box-to-circle, I recommend looking
up the formula and implementing yourself, should be easier and more performant than Box2D's more general approach.

Alright then, now we are sure that the shapes collided, next step is resolving the collision. If you're using a library
(like Box2D) everything is going to be handled for you, but the next step here is actually applying physics.

## Conclusion

While this article doesn't even scratch the surface of this subject, I hope it gives you some insight about how most games
operate. Although some games like Portal 2 or Half-Life 2 built their name over physics simulations, physics engines are more often
than not are limited to collision detection inside the physics loop, and that's what I intended to cover in this article.

For those who want to deeply understand the subject I suggest reading the book [Game Physics Engine Development](https://books.google.com.br/books?id=d0NZDwAAQBAJ).

## References

- [Game Physics Engine Development](https://books.google.com.br/books?id=d0NZDwAAQBAJ)
- [Box2D Documentation](https://box2d.org/documentation/index.html)
- [Classical Mechanics](https://en.wikipedia.org/wiki/Classical_mechanics)
