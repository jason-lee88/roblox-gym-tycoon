camera = game.Workspace.CurrentCamera
player = game.Players.LocalPlayer

game.Workspace.CurrentCamera.CameraType = "Scriptable"
game.Workspace.CurrentCamera.CameraSubject = game.Workspace["Pull-Ups"].Focus1
game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace["Pull-Ups"].CameraPart1.Position, game.Workspace["Pull-Ups"].Focus1.Position)
player.Character:Destroy()

--script:Destroy()