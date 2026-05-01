
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

    servingPlayer = 1
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
        if ball.x < 0 then
            servingPlayer = 1
            p2score = p2score + 1
            ball:reset()
            gamestate = 'serve'
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            p1score = p1score + 1
            ball:reset()
            gamestate = 'serve'
        end

        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end

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
            gamestate = 'serve'
        elseif gamestate == 'serve' then
            gamestate = 'play'
            ball:serve(servingPlayer)
        elseif gamestate == 'done' then
            gamestate = 'serve'
            ball:reset()
            p1score = 0
            p2score = 0

            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end

function love.draw()
    push.start()
    love.graphics.clear(40/255, 45/255, 52/255, 1)
    love.graphics.setFont(smallfont)
    
    if gamestate == 'start' then
        love.graphics.printf("Welcome to SPiceZ Ping Pong!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to Start", 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gamestate == 'serve' then
        love.graphics.printf("Player " .. tostring(servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to Serve", 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(largefont)
    love.graphics.print(tostring(p2score), VIRTUAL_WIDTH/2-50, 30)
    love.graphics.print(tostring(p1score), VIRTUAL_WIDTH/2+50, 30)

    player1:render()
    player2:render()
    ball:render()

    displayfps()

    push.finish()
end

function displayfps()
    love.graphics.setFont(smallfont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
