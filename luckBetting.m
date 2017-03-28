%Sc. Computing Assignment 2 QUESTION 2
%Chen Wen Kang
%Start 27/3/2017
%Try Your Luck game

%Main function
function main()
    %Setting the layout
    close all;
    clear all;
    figure('Name', 'Try Your Luck?', 'MenuBar', 'none');
	clc,clf;
	hold off;
	axis off;
	%initializing the loop condition
	gameRun = 1;
	%initializing the play condition
	life = 3;
	score = 0;
	
	%Goes to the menu
	%Exit loop when x is pressed or when user does not want to play anymore
	
	while(gameRun)
		choice = menu('<Shooting Star>', 'Start Game', 'Instructions', 'Highscore');
        switch(choice)
		case 1
			%Ends when no life is left.
			while(life>0)
				[life,score] = game(life,score);
			end
			
		case 2
			instruction();
		case 3
			highScore();
        otherwise
            gameRun = 0;
        end
	end
end

%Shows the instructions for the game
function instruction()
	msgbox({'A random number will be drawn by the computer.',
	'You are given a set number of cards which contains number between 1-10.',
	'You start with 3 lifes.',
	'You are allowed to choose between revealing a card''s number or giving up each round.',
	'If you forfiet, no life will be lost no matter the circumstances.',
	'If you reveal all the cards but the total sum is less than the generated number, you lose a life.',
	'You lose the game when you lost all your lifes!'},'Instructions','modal');
	return;
end

%Set the difficulity
function[lv] = difficulity()
	diffLv = menu('Choose the difficulity:','Easy','Intermediete','Hard');
		switch diffLv
			case 1
				lv = 0;
			case 2
				lv = 1;
			case 3
				lv = 2;
        end
end

%Main game
function[life, score] = game(life, score)
	%initialise difficulity
	d = difficulity();
	figure('Name', 'Try Your Luck!', 'MenuBar', 'none');
	%Animation
    for i=0:27
        clf;
        axis([0,30,0,30]);
		set(gca,'xticklabel',{[]});
		set(gca,'yticklabel',{[]});
        rectangle('Position', [7 30-i 3.5 7]);
        rectangle('Position', [11 30-i 3.5 7]);
        if(d>0)
        rectangle('Position', [15 30-i 3.5 7]);
        end
        if(d==2)  
			rectangle('Position', [19 30-i 3.5 7]);
        end
        pause(1/60);
    end
	
	%Game Start Prompt
	title(gca,'Game Start! xD');
	pause(2);
	
    %Show two options
	text(6, 20,'Reveal A Card');
	rectangle('Position', [5 17.25 7 5]);
	text(19.25, 20,'Forfeit Match');
	rectangle('Position', [18 17.25 7 5]);
	text(28, 29,'Exit');
	rectangle('Position', [27.75 28.5 2 1]);
	
	%Show player's life
	text(2,29,sprintf('Life : %d',life));
	
	%Generate random computer's number
	c_number=randi(20+(d*10)); 
	
	%Generate random number for player
	for(i=1:(d+2))
		u_cardNumber(i) = randi(10);
	end
	
	%Initialise coordinates for the numbers to appear
	coor = [8.5 12.5 16.5 20.5];

	%Accept mouse click as input to determine the user's action
	a = 1;
	shown = 0;
	while shown<2+d		  
		%Prompts the user to click on a card.
		title(gca,'Click reveal to reveal a card''s number.');
		[x,y]=ginput(1);
		if(x>5&&x<12&&y>17.25&&y<22.25)
			title(gca,'Your card number is...');
			pause(1);
			text(coor(a), 6.5,sprintf('%d',u_cardNumber(a)));
			title(gca,sprintf('%d!!!',u_cardNumber(a)));
			pause(2);
			a = a + 1;
			shown = shown + 1;
		end
		if(x>18&&x<25&&y>17.25&&y<22.25)
			title(gca,'Player forfieted the match :(');
			%Show all card on hand
			while(a<=2+d)
				text(coor(a), 6.5,sprintf('%d',u_cardNumber(a)));
				a = a+1;
			end
			break;
		end
		if(x>27.75&&x<29.75&&y>28.5&&y<29.5)
			title(gca,'Click Exit once more to confirm exit!');
			[x, y] = ginput(1);
			if(x>27.75&&x<29.75&&y>28.5&&y<29.5)
				life = 0;
				close all;
				return;
			end
		end
	end
	%Reveal computer's number
	pause(1);
	title(gca, sprintf('The computer''s number is : %d !', c_number));
	pause(2);
	%Check scoring condition
	if(shown==2+d)
		if(sum(u_cardNumber)>=c_number)
			title(gca, sprintf('Congratz!!! Your total sum of numbers (%d) is larger than computer''s number (%d) !',sum(u_cardNumber),c_number));
			score = score + 1;
		else
			title(gca, sprintf('Too bad, Your total sum of numbers (%d) is smaller than computer''s number (%d) !',sum(u_cardNumber),c_number));
			life = life - 1;
		end
	end
	pause(3);
	close all;
end

%Show game over dialog box
function gameOver(score, old_score)
	msgbox(sprintf('Game Over!!!\n Your Highscore is %d!',score),'Game Over','modal');
	if(score>old_score)
		warndlg('You have obtained a new highscore!','New Highscore','modal');
		fileSave();
	end
	return;
end


%Shows the Highscore
function highScore(name, score)
	msgbox(sprintf('Highscore\n%s\t%d',name,score),'Highscore','modal');
end

%Reads the old highScore
function[old_score] =  fileRead()
	
end

%Saves the new highScore
function fileSave(name, new_highScore)
	
end