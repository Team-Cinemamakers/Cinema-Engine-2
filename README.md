# Cinema Engine 2
15th competing standard: the fnf engine

# How to use?
The engine is currently in very early development and is generally unfit for usage. It is missing many of the features you would expect from an average engine.

If you want to try anyways - Currently all of the documentation is contained in the [docs](https://github.com/Team-Cinemamakers/Cinema-Engine-2/tree/main/docs) folder inside of the repository. It contains building instructions, alongside commented examples of the formats that the engine uses.

Keep in mind - Most of the things are subject to change. We will likely not be providing any converters and/or backwards compatibility support for older versions of the engine.

# What and why?
Modern FNF engines have been directly and indirectly based on the original game for years. While there isn't anything inherently wrong with that the issues come when you look at how things are organized:
- The formats are a pain to work with and are based on old, limited formats. New features have been superimposed on top for years
- The assets are disorganized due to not being moved in years
- Engine developers are afraid of fixing the above issues due to having to maintain backwards compatibility

What we are trying to do is to make an engine unbound by limitations of the past and recreating the workflow to facilitate and streamline modding.

# Our goals

## Main Goals
- Create an engine with the hindsight of modern FNF modding
- Remake systems and formats from scratch to streamline features that have been in engines for years, creating new modern standards in the process
- Improve the workflow and intuitiveness of making mods
- Provide robust HScript support 
- Create standalone editors for simpler use
- Maintain latest library and Haxe versions, and maintain code to use latest and non-deprecated features
- Implement features the team finds useful from other engines
- Create a clean codebase that seperates specific code into seperate softcoded files

## Potential Goals
- Provide converters for popular engines (Psych Engine and others) for easier porting
