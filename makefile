# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maugusto <maugusto@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/17 11:56:43 by maugusto          #+#    #+#              #
#    Updated: 2024/07/04 14:19:16 by maugusto         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = so_long
NAME_BONUS = so_long_bonus

CC = cc
CFLAGS = -Wall -Wextra -Werror -g -Iheaders/
MFLAGS = -lX11 -lXext
RM = rm -rf

LIBFT = libft/libft.a
MLX = ./minilibx-linux/libmlx_Linux.a


SRCS = 	game/so_long.c\
		game/check_path.c\
		game/controls.c\
		game/create_map.c\
		game/errors.c\
		game/get_map.c\
		
BONUS = game_bonus/so_long_bonus.c\
		game_bonus/check_path_bonus.c\
		game_bonus/controls_bonus.c\
		game_bonus/create_map_bonus.c\
		game_bonus/errors_bonus.c\
		game_bonus/get_map_bonus.c\
		game_bonus/animation_bonus.c\
		game_bonus/exit_game_bonus.c\
		game_bonus/init_img_bonus.c\
		game_bonus/put_machines_bonus.c\
		
OBJS = $(SRCS:%.c=%.o)
OBJS_BONUS = $(BONUS:%.c=%.o)
LIBRARY := -Lminilibx-linux -lmlx -lX11 -lXext -lm
MINILIBX := minilibx-linux/



all: $(NAME)

$(LIBFT):
	@$(MAKE) -C ./libft

$(MLX):
	@$(MAKE) -C ./minilibx-linux

$(NAME): $(OBJS) $(LIBFT) $(MLX)
	@$(CC) $(CFLAGS) $(OBJS) $(LIBFT) $(MLX) $(MFLAGS) -o $(NAME)

bonus: $(OBJS_BONUS) $(LIBFT) $(MLX)
	$(CC) $(CFLAGS) $(OBJS_BONUS) $(LIBFT) $(MLX) $(MFLAGS) -o $(NAME_BONUS)

clean:
	@$(MAKE) clean -C ./libft
	@$(MAKE) clean -C ./minilibx-linux
	@$(RM) $(OBJS)
	@$(RM) $(OBJS_BONUS)
	
fclean: clean
	@$(MAKE) fclean -C ./libft
	@$(MAKE) clean -C ./minilibx-linux
	@$(RM) $(NAME)
	@$(RM) $(NAME_BONUS)

download:
	@wget https://cdn.intra.42.fr/document/document/21300/minilibx-linux.tgz
	@tar -xzf minilibx-linux.tgz
	@rm minilibx-linux.tgz
re: fclean all