
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require "push"

function love.load()
    -- Set up the game window
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("SPiceZ Ping Pong")
    
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, {
        upscale = "normal",
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    push.start()
    love.graphics.printf("Welcome to SPiceZ Ping Pong!", 0, VIRTUAL_HEIGHT/2-6, VIRTUAL_WIDTH, "center")
    push.finish()
end