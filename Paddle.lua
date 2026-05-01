Paddle = {}
Paddle.__index = Paddle

function Paddle:new(x, y, width, height)
    local instance = setmetatable({}, Paddle)
    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.dy = 0
    return instance
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
