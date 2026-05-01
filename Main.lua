
WINDOW_HIEGHT = 1270
WINDOW_WIDTH = 720

function love.load()
    -- Set up the game window
    love.window.setTitle("SPiceZ Ping Pong")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HIEGHT, { resizable = false, vsync = true, fullscreen = false})
end

function love.draw()
    love.graphics.printf("Welcome to SPiceZ Ping Pong!", 10, 10, WINDOW_WIDTH, "center")
end