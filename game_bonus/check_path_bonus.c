/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   check_path_bonus.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: maugusto <maugusto@student.42porto.com>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/04 11:16:39 by maugusto          #+#    #+#             */
/*   Updated: 2024/07/08 11:39:47 by maugusto         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../so_long_bonus.h"

static void	flood_fill(t_idk *game, int height, int width, int **visited)
{
	if (visited[height][width] || game->map[height][width] == '1')
		return ;
	visited[height][width] = 1;
	visiting(game, height + 1, width, visited);
	visiting(game, height - 1, width, visited);
	visiting(game, height, width + 1, visited);
	visiting(game, height, width - 1, visited);
}

static int	check_valid(t_idk *game, int height, int **visited)
{
	int	path;
	int	width;

	path = 1;
	while (height < game->heightmap)
	{
		width = 0;
		while (width < game->widthmap)
		{
			if ((game->map[height][width] == 'C')
				&& !visited[height][width])
			{
				path = 0;
				break ;
			}
			width ++;
		}
		if (!path)
			break ;
		height++;
	}
	if ((game->exit_visit == 1 && game->collectables_check
			< game->collectables) || game->exit_visit == 0)
		path = 0;
	return (path);
}

int	check_path(t_idk *game)
{
	int			height;
	static int	**visited;

	visited = malloc(game->heightmap * sizeof(int *));
	height = 0;
	while (height < game->heightmap)
		visited[height++] = ft_calloc(game->widthmap, sizeof(int));
	visiting(game, game->j, game->i, visited);
	height = 0;
	if (!check_valid(game, height, visited))
	{
		height = 0;
		while (height < game->heightmap)
			free(visited[height++]);
		free(visited);
		ft_printf("Error\nNot all collectables or exits are reachable!\n");
		return (0);
	}
	height = 0;
	while (height < game->heightmap)
		free(visited[height++]);
	free(visited);
	return (1);
}
