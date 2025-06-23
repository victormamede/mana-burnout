---
layout: post
title: The Best Language for Programmers
description: Computers often seem like black magic. This article is about how understanding your own language can help you understand the inner workings of a computer
date: 2025-06-19
feature_image: images/code.jpg
tags: [software, programming]
author: mamede
---

Computers often seem like black magic, even veteran programmers who work with these machines every day might not know their intricacies. This article is about how mastering your own language can help you understand the inner workings of a computer.

<!--more-->

## Learning your own language

> "Besides a mathematical inclination, an exceptionally good mastery of one's native tongue is the most vital asset of a competent programmer."
>
> -- Edsger W. Dijkstra

I recently came across this quote by Dijkstra which promptly inspired me to create a blog just to talk about it (that's how strongly I feel about this quote).

I've always been deeply drawn to STEM fields, which naturally drew me to become a programmer. But I also very much enjoyed the study of grammar, the way we use words to conceive and transport information is something that truly perplexes me. I think the reason I found something seemingly outside of my areas of interest so fascinating is very simple: **Language is Mathematics**.

While I can't speak of exactly what Dijkstra meant by these words, I can tell you my understanding of how this is related to computers.

## What is a computer

At its core, a computer's job is to follow instructions. Programmers are well acquainted with the [Turing Machine](https://en.wikipedia.org/wiki/Turing_machine) and its extremely simple concept: you have a tape divided into squares, each square containing some information, and you have a robot, the robot has a state and a manual of instructions. The robot is capable of reading exactly one square at a time and the manual contains a list of instructions like "if you read a 0, move to the right" or "if you read a 1, jump 2 squares".

Lo and behold, this machine can do everything any computer in the world can, this is both the minimum and the maximum needed to be called a computer. If you want to know more about the Turing Machine there's [this amazing video](https://www.youtube.com/watch?v=dNRDvLACg5Q) from Computerphile.

The main part of the computer is the **processor**, and much alike the robot I talked about, the processor has an **instruction set** which, together with the **program**, is analogous to the robot's manual (for curiosity's sake, your common computer/laptop processor follows the [x86-64](https://en.wikipedia.org/wiki/X86-64) architecture, here's the [instruction set](https://www.felixcloutier.com/x86/) for those).

I think of the **instruction set** as the robot's "capabilities", inside the processor you will have groups of logical gates that can perform addition, subtraction, jump to another instruction and everything else the processor is capable of. While the **program** is a sequence of indexed instructions: executing them in order gets you the program's result.

## Programming languages

Turns out writing programs for the CPU is extremely difficult. Not only do you have to learn each target architecture's instructions, you also have to manage various things that make the program possible, like the program counter, registers, memory, peripherals and more. That's why we usually don't write programs like that, we *abstract*.

For our day-to-day, we use programming languages, they can be compiled, interpreted or something in-between. Compiled languages pass through something called a compiler, which translates our abstracted, human-readable code into that list of instructions, while interpreted languages pass through the *interpreter* that reads the program line by line and - gasp - interprets it, there are also languages that compile the code into an intermediary language that passes through an interpreter.

When you want a computer to do something, solve a problem, you write a program in an easier language, that gets translated to another language before the computer can execute it. Also, different programming languages have different benefits, there is no one-size-fits-all in computers, you may have to learn a bunch of languages and tools in your programming career.

## AI

I don't believe AI is going to take our jobs, as some CEOs like to claim and blabber about, but it has become unquestionably a powerful tool at our disposal. I also don't think that *prompt engineering* is particularly useful, but I do know for a fact that you can extract better data from those tools by simply talking in their language.

LLMs produce better output if you talk to them in a particular way, and while I'm no expert in that field I found that I can leverage their power better than most of my peers by simply understanding better my problem and communicating better.

## Beyond coding

As a programmer, you'll definitely work with other people too, and, working with other people, you need to hear and understand your colleagues accordingly. More often than not, the project is way too complex for just one person to get everything, explain details of your part of the system and understand your colleagues - even if they aren't the best communicators themselves - are all perks of a good language skill.

This skill is even more handy if you're managing the project, now you have different kinds of people, with different backgrounds and education levels that all need to be part of the project. They may all speak English but the way you talk to your team is different from the way you talk to your boss - and different to the way you talk to your clients. At the end of the day, the information you pass to each one is the same, but they are all conveyed in different forms and it's your job to master all of them.

## What language is best?

Programming, at its core, is communication. It's not a coincidence that people who already know various languages can pick up a new one way faster than people learning their second language. I think that is because those people have a deep understanding of Language itself, and that is true for computers too, if you know only javascript it's difficult to pick up C or C++, but once you understand deeply the language of computers, it's easy to pick up any programming language.

By now you have probably realized that being a programmer is not about mastering C or Python (although that's certainly a part of it), a programmer's job is to give instructions: to the computer, to your colleagues, to your boss and to your clients. Great programmers aren't obsessed with one particular language; they learn new tools and adapt as needed.

Ultimately, I think that what Dijkstra meant is that, besides mathematics, programming boils down to one thing: communication, and the best way to become a great communicator is to learn your own language and talk to others. Clarity and precision aren't good just for writing essays, they are the core of everything you do as a programmer.

If you are just starting I'd recommend to just pick whatever language you like and talk to other programmers, and if you're a veteran trying to further advance your career, try to understand deeply the language of the computer and, more importantly, your own.
