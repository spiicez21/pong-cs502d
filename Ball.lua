Ball = {}
Ball.__index = Ball

function Ball:new(x, y, width, height)
    local instance = setmetatable({}, Ball)
    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.dx = math.random(2) == 1 and 100 or -100
    instance.dy = math.random(-50, 50)
    return instance
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = 0
    self.dy = 0
end

function Ball:serve(player)
    self.dx = player == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:collides(paddle)
    if self.x >= paddle.x + paddle.width or paddle.x >= self.x + self.width then
        return false
    end
    if self.y >= paddle.y + paddle.height or paddle.y >= self.y + self.height then
        return false
    end

    return true
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
