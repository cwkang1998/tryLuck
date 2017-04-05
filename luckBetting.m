%Sc. Computing Assignment 2 QUESTION 2
%Chen Wen Kang
%Start 27/3/2017

%Try Your Luck game
%A card game that is derived from blackjack but is relatively simpler.
%It involves a human playing against a computer with a random hand of cards with number from 1-10
%attempting to prevent the lost of lives while trying to make sure your hand have a
%higher total sum than the computer's hand.

%Main function
%This function is the main function that runs and calls all the other functions
function main()
    %Close all unneeded windows and clear all data
    close all;
    clear all;
	%initializing the loop condition for the game to run at least once
	gameRun = 1;
	
	%Goes to the menu
	%Exit loop when x is pressed or when user does not want to play anymore
	while(gameRun)
        %initializing the play condition
        life = 3;
        score = 0;
        lv = -1;
        %Open up gui 
		choice = menu('<Try Your Luck!>', 'Start Game', 'Instructions', 'Highscore');
        switch(choice)
		case 1
			%check and initialise for difficulity settings
			while(lv==-1)
				lv = difficulity();
			end
			%Ends when no life is left.
			while(life>0)
				[life,score] = game(life,score,lv);
			end
			%Only runs if player loses the game and does not trigger when
			%players clicks exit
			if(life==0)
				%Opens up a gameover dialog box
				gameOver(score);
			end			
		case 2
			%Opens the instructions dialog that only returns to the main menu
			%after any button is pressed
			instructions();
		case 3
			%Opens the highScore dialog that only returns to the main menu
			%after any button is pressed
			highScore();
        otherwise
			%Exits the game when the 'x' button is pressed
            gameRun = 0;
        end
	end
end

%Shows the instructions for the game
function instructions()
	h = msgbox({'A random number will be drawn by the computer.',
	'You and the computer are given a set number of cards which contains number between 1-10.',
	'You start with 3 lifes.',
	'You are given a choice to reveal a card''s number or forfieting each round.',
	'When you reveal a card, the computer will also reveal a card.',
	'If you forfiet, no life will be lost no matter the circumstances.',
	'If you reveal all the cards and your total sum is more than the computer''s total sum, you gain 100 points.',
	'If you reveal all the cards but the total sum is less than the computer''s total sum, you lose a life.',
	'You lose the game when you lost all your lifes!'},'Instructions','modal');
	%Waits for the player to press any button
	uiwait(h);
end

%Set the difficulity via the manipulation of the number of cards that exist
function[lv] = difficulity()
	diffLv = menu('Choose the difficulity:','Easy','Intermediete','Hard');
	%Depending on the difficulity, values will be passed to the game function
	%The values will alter the number of number generated as well as
	%The numbers of card displayed
	switch diffLv
		case 1
			lv = 0;
		case 2
			lv = 1;
		case 3
			lv = 2;
		otherwise
			lv = -1;
    end
end

%Main game function
%Pause function are used frequently here:
%-To allow the players read the letters and comprehend
%-To slow down the iteration rate to a point where it provides a smooth animation
function[life, score] = game(life, score, lv)
	%Initialise the name of the figure window
	figure('Name', 'Try Your Luck!', 'MenuBar', 'none','NumberTitle','off');
	%Animation for the  your cards
    for i=0:28
		%Clear figure everytime the loop is iterated for animation effect
        clf;
		%Sets up the graph figure
        axis([0,30,0,30]);
		set(gca,'xticklabel',{[]});
		set(gca,'yticklabel',{[]});
		%Draws the players card
        rectangle('Position', [7 30-i 3.5 7]);
        rectangle('Position', [11 30-i 3.5 7]);
		%depending on the difficulity lv the other 2 cards might or might not be drawn
        if(lv>0)
			rectangle('Position', [15 30-i 3.5 7]);
        end
        if(lv==2)  
			rectangle('Position', [19 30-i 3.5 7]);
        end
		%Create a animation that is 60 fps using pause function
        pause(1/60);
    end
	
	%Animation for the computer's cards
    for i=0:20
        clf;
        axis([0,30,0,30]);
		set(gca,'xticklabel',{[]});
		set(gca,'yticklabel',{[]});
		%redrawing players cards
		rectangle('Position', [7 2 3.5 7]);
        rectangle('Position', [11 2 3.5 7]);
		%depending on the difficulity lv the other 2 cards might or might not be drawn
        if(lv>0)
			rectangle('Position', [15 2 3.5 7]);
        end
        if(lv==2)  
			rectangle('Position', [19 2 3.5 7]);
        end
		%drawing computer cards
        rectangle('Position', [7 39-i 3.5 7]);
        rectangle('Position', [11 39-i 3.5 7]);
		%depending on the difficulity lv the other 2 cards might or might not be drawn
        if(lv>0)
			rectangle('Position', [15 39-i 3.5 7]);
        end
        if(lv==2)  
			rectangle('Position', [19 39-i 3.5 7]);
        end
		%Create a animation that is 60 fps using pause function
        pause(1/60);
    end
	
	%Game Start Prompt
	title(gca,'Game Start! xD');
	pause(1);
	
	%Card label to show which side is the player's card
	text(1, 5,'Your Cards :');
	text(1, 23,sprintf('Computer''s \n Cards :'));
	
    %Draw the buttons(options) that are clickable
	rectangle('Position', [5 13.25 7 1.5],'FaceColor',[1 0.95 0.8]);
	text(5.75, 14,'Reveal A Card');
	rectangle('Position', [18 13.25 7 1.5],'FaceColor',[1 0.95 0.8]);
	text(19, 14,'Forfeit Match');
	rectangle('Position', [27.75 28.5 2 1],'FaceColor',[1 0.95 0.8]);
	text(28, 29,'Exit');
	
	%Show player's life and score
	text(2,29,sprintf('Life : %d',life));
    text(5,29,' | ');
	text(6,29,sprintf('Score : %d',score));
	
	%Generate random card number for computer
    for(i=1:(lv+2))
		c_number(i) = randi(10);
	end
	
	%Generate random card number for player
	for(i=1:(lv+2))
		u_cardNumber(i) = randi(10);
	end
	
	%Initialise coordinates for the numbers to appear on the cards
	coor = [8.5 12.5 16.5 20.5];

	%variable 'a' counts the iteration to make sure the coordinate moves
	%to the next element in the arrays in each iteration
	a = 1;
	%'shown' variable count how many card is shown
	shown = 0;
	while shown<2+lv		  
		%Prompts the user to click on a card.
		title(gca,'Click reveal to reveal a card''s number.');
		[x,y]=ginput(1);
		if(x>5&&x<12&&y>13.25&&y<14.75)
			%Prompt player that their card is being revealed
			title(gca,'Your card number is...');
			pause(1);
			text(coor(a), 6.5,sprintf('%d',u_cardNumber(a)));
			title(gca,sprintf('%d!!!',u_cardNumber(a)));
			pause(1);
			%Prompt player that computer's card is being revealed
			title(gca,'Computer''s card number is...');
			pause(1);
			text(coor(a), 23.5,sprintf('%d',c_number(a)));
			title(gca,sprintf('%d!!!',c_number(a)));
			pause(1);
			%Increment of counter variables
			a = a + 1;
			shown = shown + 1;
		end
		%Check for forfieting of the match
		if(x>18&&x<25&&y>13.25&&y<14.75)
			title(gca,'Player forfieted the match :(');
			%Show all card on player's and computer's hand
			while(a<=2+lv)
				text(coor(a), 6.5,sprintf('%d',u_cardNumber(a)));
				text(coor(a), 23.5,sprintf('%d',c_number(a)));
				a = a+1;
			end
			break;
		end
		%If player clicks the exit button, handle the exit event
		if(x>27.75&&x<29.75&&y>28.5&&y<29.5)
			%Ask for double confirm in case player click in on accident
			title(gca,'Click Exit once more to confirm exit!');
			[x, y] = ginput(1);
			if(x>27.75&&x<29.75&&y>28.5&&y<29.5)
				life = -1;
				close all;
				return;
			end
		end
	end
	%Show the total of player's number and the total of computer's number
	pause(1);
	title(gca, sprintf('The player''s total number is : %d !', sum(u_cardNumber)));
	pause(1.5);
	title(gca, sprintf('The computer''s total number is : %d !', sum(c_number)));
	pause(1.5);
	%Check scoring condition by looking at the sum of both parties
	%Show msg to notify if they won or lost
	if(shown==2+lv)
		if(sum(u_cardNumber)>sum(c_number))
			title(gca, sprintf('Congratz!!! Your total sum of numbers (%d) is larger than computer''s number (%d) !',sum(u_cardNumber),sum(c_number)));
			score = score + 100;
        elseif(sum(u_cardNumber)==sum(c_number))
			title(gca, sprintf('Its a draw! Your total sum of numbers (%d) is equals to the computer''s number (%d) !',sum(u_cardNumber),sum(c_number)));
			score = score + 100;
        else
			title(gca, sprintf('Too bad, Your total sum of numbers (%d) is smaller than computer''s number (%d) !',sum(u_cardNumber),sum(c_number)));
			life = life - 1;
		end
	end
	%Wait a few seconds before going into the next game
	pause(2.5);
	%Close all remaining windows
	close all;
end

%Show game over dialog box
function gameOver(score)
	%Show player's total score
	h = msgbox(sprintf('Game Over!!!\n Your score is %d!',score),'Game Over','modal');
	uiwait(h);
	%Call fileRead function to read the previous highscore if there are any
	[old_name, old_score] = fileRead();
	%if a new highscore is obtained then prompt the player for their name
	%and save their data into the files by calling the fileSave function
	if(score>old_score)
		h = warndlg('You have obtained a new highscore!','New Highscore','modal');
		uiwait(h);
		name = cell2mat(inputdlg('Enter your name : ','New Highscore!',1));
		fileSave(name, score);
	end
	return;
end


%Shows the Highscore
function highScore()
	%Call the fileRead function to read the previous highscore
	[name,score] = fileRead();
	h = msgbox(sprintf('Highscore:\n%s\n%d',name,score),'Highscore','modal');
	%Wait until player presses some button
	uiwait(h);
end

%Reads the old highScore
function[old_name,old_score] =  fileRead()
	%Attempt to open files.
	%Note that a negative value will be obtained if file does not exist
	nameFile = fopen('name','r');
	scoreFile = fopen('score','r');
	%if file does not exist then return no name and a value of 0
	if(nameFile<0&&scoreFile<0)
		old_name = '-';
		old_score = 0;	
	%if it exists then return the data obtained
	else
		old_name = fscanf(nameFile,'%s');
		old_score = fscanf(scoreFile,'%d');
		fclose(nameFile);
		fclose(scoreFile);
	end
end

%Saves the new highScore
function fileSave(name, new_highScore)
	%Open the files for writing
	nameFile = fopen('name','w');
	scoreFile = fopen('score','w');
	%Write the files
	fprintf(nameFile, '%s', name);
	fprintf(scoreFile, '%d', new_highScore);
	%Closing the files
	fclose(nameFile);
	fclose(scoreFile);
end