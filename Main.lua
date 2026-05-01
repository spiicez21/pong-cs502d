
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require "push"
require "Paddle"
require "Ball"

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
   
    largefont = love.graphics.newFont('font.ttf', 32)
    smallfont = love.graphics.newFont('font.ttf', 8)

    math.randomseed(os.time())

    gamestate = 'start'

    player1 = Paddle:new(10, 30, 5, 20)
    player2 = Paddle:new(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 5, 20)
    ball = Ball:new(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

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

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gamestate == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gamestate == 'start' then
            gamestate = 'play'
        else
            gamestate = 'start'
            ball:reset()
        end
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

    player1:render()
    player2:render()
    ball:render()

    push.finish()
end