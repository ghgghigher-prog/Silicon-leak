local TweenService = game:GetService("TweenService")

local SoundService = game:GetService("SoundService")

local Players = game:GetService("Players")



local Silicon = {}

Silicon.Accent = Color3.fromRGB(0,175,255)

Silicon.NotificationSoundEnabled = true



local Notifications = {}

local MaxVisible = 4



local function tween(obj,info,props)

	return TweenService:Create(obj,info,props)
end



function Silicon:Notify(data)

	task.spawn(function()

		local TitleText = data.Title or "Notification"

        local ContentText = data.Content or "Message"

        local Mute = data.Mute == true



        local gui = Instance.new("ScreenGui")

        gui.ResetOnSpawn = false

        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")



        local BG = Instance.new("Frame")

        BG.Size = UDim2.new(0,360,0,100)

        BG.AnchorPoint = Vector2.new(1,1)



        BG.Position = UDim2.new(1, 380, 1, -10)



        BG.BackgroundColor3 = Color3.fromRGB(22,22,24)

        BG.Parent = gui

        Instance.new("UICorner",BG).CornerRadius = UDim.new(0,8)



        local Shadow = Instance.new("ImageLabel")

        Shadow.Size = UDim2.new(1,0,1,0)

        Shadow.BackgroundTransparency = 1

        Shadow.Image = "rbxassetid://1316045217"

        Shadow.ImageTransparency = 0.8

        Shadow.ScaleType = Enum.ScaleType.Slice

        Shadow.SliceCenter = Rect.new(10,10,118,118)

        Shadow.ZIndex = 0

        Shadow.Parent = BG



        local Icon = Instance.new("ImageLabel")

        Icon.Size = UDim2.new(0,44,0,44)

        Icon.Position = UDim2.new(0,20,0,21)

        Icon.BackgroundColor3 = Color3.fromRGB(28,28,32)

        Icon.Image = "rbxassetid://124780615486303"

        Icon.Parent = BG

        Instance.new("UICorner",Icon).CornerRadius = UDim.new(0,8)

        local Stroke = Instance.new("UIStroke",Icon)

        Stroke.Color = Silicon.Accent

        Stroke.Thickness = 1.5



        local Title = Instance.new("TextLabel")

        Title.Position = UDim2.new(0,80,0,15)

        Title.Size = UDim2.new(1,-100,0,26)

        Title.BackgroundTransparency = 1

        Title.Font = Enum.Font.GothamBold

        Title.TextSize = 19

        Title.TextColor3 = Color3.new(1,1,1)

        Title.TextXAlignment = Enum.TextXAlignment.Left

        Title.Text = TitleText

        Title.Parent = BG



        local Desc = Instance.new("TextLabel")

        Desc.Position = UDim2.new(0,80,0,31)

        Desc.Size = UDim2.new(1,-100,0,36)

        Desc.BackgroundTransparency = 1

        Desc.Font = Enum.Font.Gotham

        Desc.TextSize = 14

        Desc.TextColor3 = Color3.fromRGB(190,190,190)

        Desc.TextWrapped = true

        Desc.TextXAlignment = Enum.TextXAlignment.Left

        Desc.Text = ContentText

        Desc.Parent = BG



        local BarBG = Instance.new("Frame")

        BarBG.Size = UDim2.new(1,-32,0,4)

        BarBG.Position = UDim2.new(0,16,1,-14)

        BarBG.BackgroundColor3 = Color3.fromRGB(18,18,20)

        BarBG.Parent = BG

        Instance.new("UICorner",BarBG).CornerRadius = UDim.new(0,2)



        local Bar = Instance.new("Frame")

        Bar.Size = UDim2.new(0,0,1,0)

        Bar.BackgroundColor3 = Silicon.Accent

        Bar.Parent = BarBG

        Instance.new("UICorner",Bar).CornerRadius = UDim.new(0,2)



        if not Mute and Silicon.NotificationSoundEnabled then

            local s = Instance.new("Sound",SoundService)

            s.SoundId = "rbxassetid://1788243907"

            s.Volume = 0.7

            s.PlayOnRemove = true

            s:Destroy()

        end



        table.insert(Notifications,1,gui)

        if #Notifications > MaxVisible then

            Notifications[#Notifications]:Destroy()

            table.remove(Notifications,#Notifications)

        end



        BG.BackgroundTransparency = 1

        Icon.ImageTransparency = 1

        Title.TextTransparency = 1

        Desc.TextTransparency = 1

        BarBG.BackgroundTransparency = 1

        Bar.BackgroundTransparency = 1



        tween(BG,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{

            Position = UDim2.new(1,-10,1,-10),

            BackgroundTransparency = 0

        }):Play()



        task.wait(0.1)

        tween(Icon,TweenInfo.new(0.4),{ImageTransparency = 0}):Play()

        tween(Title,TweenInfo.new(0.4),{TextTransparency = 0}):Play()

        task.wait(0.05)

        tween(Desc,TweenInfo.new(0.4),{TextTransparency = 0}):Play()

        tween(BarBG,TweenInfo.new(0.4),{BackgroundTransparency = 0}):Play()

        tween(Bar,TweenInfo.new(0.4),{BackgroundTransparency = 0}):Play()

        tween(Bar,TweenInfo.new(3,Enum.EasingStyle.Linear),{Size = UDim2.new(1,0,1,0)}):Play()



        task.delay(3.2,function()

            if gui.Parent then

                tween(BG,TweenInfo.new(0.5,Enum.EasingStyle.Quint),{

                    Position = UDim2.new(1,380,1,-10),

                    BackgroundTransparency = 1

                }):Play()



                task.delay(0.5,function()

                    if gui.Parent then

                        gui:Destroy()

                        for i=#Notifications,1,-1 do

                            if Notifications[i]==gui then table.remove(Notifications,i) end

                        end

                    end

                end)

            end

        end)

    end)

end



-- insert fucking notif here for testing



return Silicon