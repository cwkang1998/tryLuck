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
	%initializing the difficulity lv to easy
	diffLv = 0;
	%initializing the play condition
	playAgn = 1;
	
	%Goes to the menu
	%Exit loop when x is pressed or when user does not want to play anymore
	
	while(playAgn)
		choice = menu('<Shooting Star>', 'Start Game', 'Instructions', 'Highscore');
        switch(choice)
		case 1
			playAgn = game();
		case 2
			instruction();
		case 3
			highScore();
        otherwise
            playAgn = 0;
        end
	end
end

%Shows the instructions for the game
function instruction()
	msgbox({'A random number will be drawn by the computer.',
	'You are given a set number of cards which contains number between 1-10.',
	'You start with 3 lifes.',
	'You are allowed to choose between revealing a card''s number or giving up each round.',
	'If you give up, no life will be lost no matter the circumstances.',
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
function[playAgain] = game()
	d = difficulity();
	clf;
    
	%Card animation
    x=13.25;
    y=13.25;
	figure('Name', 'Try Your Luck!', 'MenuBar', 'none');
	set(gca,'xticklabel',{[]});
	set(gca,'yticklabel',{[]});
    for i=0:10
        clf;
        axis([0,30,0,35]);
		axis off;
        rectangle('Position', [x-i y-i 3.5 7]);%coordinate(3.25,3.25)
        rectangle('Position', [x+i y-i 3.5 7]);%coordinate(23.25,3.25)
        if(d>0)
			rectangle('Position', [x-i y+i 3.5 7]);%coordinate(3.25,23.25)
        end
        if(d==2)  
			rectangle('Position', [x+i y+i 3.5 7]);%coordinate(23.25,23.25)
        end
        pause(1/60);
    end
	
	%Create middle deck which contains computer's no.
	text(14.5, 19.25,'@');
	rectangle('Position', [13.25 15.25 3.5 7]);
    
	c_number=randi(20+(d*10)); 

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