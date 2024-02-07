clc
clear

replay = 'space';
while strcmp(replay, 'space')
    ace_check = 1;

    blackjack_scene = simpleGameEngine('retro_cards.png', 16, 16, 8, [255, 255, 255]);
    skip_sprites = 20;

    card_vals = randi(13, 1, 2);
    card_suits = randi(4, 1, 2) - 1;

    dealer_vals = randi(13, 1, 1);
    dealer_suits = randi(4, 1, 1) - 1;
    BLACKJACK = 21;
    DEALER_STAND = 17;
    player_sprites = skip_sprites + 13 * card_suits + card_vals;
    player_fill = ones(1, 8);
    dealer_sprites = skip_sprites + 13 * dealer_suits + dealer_vals;
    blankcard = 3;
    dealer_fill = ones(1, 9 - length(dealer_sprites));
    drawScene(blackjack_scene, [dealer_sprites, blankcard, dealer_fill; 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; player_sprites, player_fill])
    face_cards = [31, 32, 33, 33, 44, 45, 46, 57, 58, 59, 70, 71, 72];
    fprintf('Welcome to Lil Lucky 21! \nPress space to begin playing and press tab to read the rules of blackjack \n')
    play = getKeyboardInput(blackjack_scene);

    while strcmp(play, 'tab')
        msgbox('BlackJack is a game to 21, but you don''t want to go over. Press space to begin playing.')
        play = getKeyboardInput(blackjack_scene);
    end

    while strcmp(play, 'space')
        for k = 1:length(card_vals)
            if ismember(player_sprites(k), face_cards)
                card_vals(k) = 10;
            end
            if card_vals(k) == 1
                ace_check = input('Would you like the ace to be worth 1 or 11?', 's');
                ace_check = str2double(ace_check);
                if ace_check == 1
                    card_vals(k) = 1;
                elseif ace_check == 11
                    card_vals(k) = 11;
                end
            end
        end

        fprintf('Do you want to hit? (space bar = hit, backspace = stay)\n')
        key = getKeyboardInput(blackjack_scene);

        pause(0.5);

        title(key);

        if strcmp(key, 'space')
            card_vals = [card_vals, randi(13)];
            card_suits = [card_suits, randi(4) - 1];
            player_fill = ones(1, (8 - i));
            player_sprites = skip_sprites + 13 * card_suits + card_vals;
            drawScene(blackjack_scene, [dealer_sprites, blankcard, dealer_fill; 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; player_sprites, player_fill])
            i = i + 1;
            for k = 1:length(card_vals)
                if ismember((player_sprites(k)), face_cards)
                    card_vals(k) = 10;
                end
            end
            if sum(card_vals) > 21
                break;
            end
        elseif strcmp(key, 'backspace')
            fprintf("Player Stays. \n");
            for k = 1:length(card_vals)
                if ismember((player_sprites(k)), face_cards)
                    card_vals(k) = 10;
                end
            end
            break;
        end
    end

    while 1
        dealer_vals = [dealer_vals, randi(13)];
        dealer_suits = [dealer_suits, randi(4) - 1];
        dealer_sprites = skip_sprites + 13 * dealer_suits + dealer_vals;
        n = 0;
        dealer_fill = ones(1, (10 - length(dealer_sprites)));
        drawScene(blackjack_scene, [dealer_sprites, dealer_fill; 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; player_sprites, player_fill])

        if sum(dealer_vals) > sum(card_vals) || sum(card_vals) > 21
            break;
        elseif sum(dealer_vals) >= DEALER_STAND && (sum(dealer_vals) < sum(hand_val) || (sum(hand_val) <= BLACKJACK && sum(dealer_vals) <= BLACKJACK))
            dealer_vals = [dealer_vals, randi(13)];
            dealer_suits = [dealer_suits, randi(4) - 1];
            dealer_sprites = skip_sprites + 13 * dealer_suits + dealer_vals;
            dealer_fill = ones(1, (10 - length(dealer_sprites)));
            drawScene(blackjack_scene, [dealer_sprites, dealer_fill; 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; player_sprites, player_fill])
            n = n + 1;
            break;
        end
    end

    % Ensure the dealer's values are not greater than 10
    for k = 1:length(dealer_vals)
        if dealer_vals(k) > 10
            dealer_vals(k) = 10;
        end
    end

    dealer_val = sum(dealer_vals);
    hand_val = sum(card_vals);
    Winner = checkWinner(dealer_val, hand_val);
    fprintf('The winner is %s\n', Winner)
    fprintf('Would you like to play again? \nPress space to play again, press backspace to leave the game \n')
    replay = getKeyboardInput(blackjack_scene);
    if strcmp(replay, 'backspace')
        fprintf('Thanks for playing. Goodbye! \n')
        break
    end
end
clf
