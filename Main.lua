
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require "push"

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
   
    largefont = love.graphics.newFont('font.ttf', 32)
    smallfont = love.graphics.newFont('font.ttf', 8)

    love.window.setTitle('SPiceZ Ping Pong')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, {
        upscale = 'normal',
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push.start()
    love.graphics.clear(45/255, 50/255, 20/255,1)
    love.graphics.setFont(smallfont)
    love.graphics.printf("Welcome to SPiceZ Ping Pong!", 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
    push.finish()
end