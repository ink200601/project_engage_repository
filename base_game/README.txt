This document is to teach how the structuring of this project, weither you are a new team member, or a modder.

first off, lets go over the fileing format, it should be pretty self explainitory, but lets go over it just in case.


Fighters

the "fighters" folder, obviously, contains all the fighter data, the stars of the show,
Inside all of these folders will be more folders, each corisponding to an indevidual fighter, so, if you want to create
a new fighter, start with createing a folder, in this folder.
all of the fighter folders will contain the files for each fighter, the file labeled "(fightername)_fight.tscn" is the 
fighter itself, containing the editor file for the fighter.
the file labeled as "(fightername)_param.gd" are all of the characters data.
the file labled as "(fightername)_ai.gd" contains all of the data on how the fighter should act as a computer player
the "action" folder contains all of the data for the attacks, or other actions the fighter can perform
under this folder, are said action files, with a very strange naming skeem but a logical one, (more on that later)


Data

the "data" folder contains the game data, things like hitbox's, random number generators, and esentually all the 
stuff that makes the game run, if your a modder, you dont want to mess with these files unless you really know what
your doing.

