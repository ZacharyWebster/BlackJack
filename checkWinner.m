function [winner] = checkWinner(dealer_val,hand_val)
%This is our function designed to detect the winner of the blackjack hand
%at the end of our code the inputs are the values or the player and dealers
%hands then using if else statements detemines the winner and outputs it to
%the main method
winner = 0;
if hand_val > 21
    fprintf('Player Busted! Better luck next time :(\n');
    winner = 'Dealer';
elseif dealer_val > 21
    fprintf('Dealer Busted! Congratulations, you win!\n');
    winner = 'Player';
elseif hand_val > dealer_val
    fprintf('Congratulations, you win!\n');
    winner = 'Player';
elseif hand_val < dealer_val
    fprintf('Sorry, you lose. Dealer wins.\n');
    winner = 'Dealer';
else
    fprintf('It''s a tie!\n');
    winner = 'Tie';
end
end