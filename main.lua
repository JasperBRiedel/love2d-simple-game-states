game = {
  current_state = "menu",
  states = {
    menu = {},
    scoreboard = {},
    playing = {
      player_x = 0,
      player_y = 0,
      player_speed = 100,
    },
  }
}

function game:link_event(event)
  love[event] = function(...)
    if self.states[self.current_state] ~= nil then
      if self.states[self.current_state][event] ~= nil then
        self.states[self.current_state][event](self.states[self.current_state], ...)
      end
    end
  end
end

game:link_event("draw")
game:link_event("update")
game:link_event("keypressed")

function game.states.menu:draw()
  love.graphics.print("This is the menu state. Press space to start the game.")
end

function game.states.menu:keypressed(key)
  if key == "space" then
    game.current_state = "playing"
  end
end

function game.states.playing:draw()
  love.graphics.print("Press space to end the game")
  love.graphics.rectangle("fill", self.player_x, self.player_y, 100, 100)
end

function game.states.playing:keypressed(key)
  if key == "space" then
    game.current_state = "scoreboard"
  end
end

function game.states.playing:update(dt)
  if love.keyboard.isDown("a") then
    self.player_x = self.player_x - self.player_speed * dt
  end
  if love.keyboard.isDown("w") then
    self.player_y = self.player_y - self.player_speed * dt
  end
  if love.keyboard.isDown("s") then
    self.player_y = self.player_y + self.player_speed * dt
  end
  if love.keyboard.isDown("d") then
    self.player_x = self.player_x + self.player_speed * dt
  end
end

function game.states.scoreboard:draw()
  love.graphics.print("This is the scoreboard. Press space to return to the menu")
end

function game.states.scoreboard:keypressed(key)
  if key == "space" then
    game.current_state = "menu"
  end
end
