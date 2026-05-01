
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require "push"

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
   
    largefont = love.graphics.newFont('font.ttf', 32)
    smallfont = love.graphics.newFont('font.ttf', 8)

    p1score = 0
    p2score = 0

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
    love.graphics.clear(40/255, 45/255, 52/255,1)
    love.graphics.setFont(smallfont)
    love.graphics.printf("Welcome to SPiceZ Ping Pong!", 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(largefont)
    love.graphics.print(tostring(p2score), VIRTUAL_WIDTH/2-50, 30)
    love.graphics.print(tostring(p1score), VIRTUAL_WIDTH/2+50, 30)

    --paddle1
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    --paddle2
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 5, 20)
    --ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - 2, VIRTUAL_HEIGHT/2 - 2, 4, 4)

    push.finish()
end