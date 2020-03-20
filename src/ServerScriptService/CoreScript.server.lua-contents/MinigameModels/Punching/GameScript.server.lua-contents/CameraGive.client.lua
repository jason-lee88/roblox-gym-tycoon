camera = game.Workspace.CurrentCamera
player = game.Players.LocalPlayer

game.Workspace.CurrentCamera.CameraType = "Scriptable"
game.Workspace.CurrentCamera.CameraSubject = game.Workspace.Punching.Focus1
game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.Punching.CameraPart1.Position, game.Workspace.Punching.Focus1.Position)
player.Character:Destroy()

--script:Destroy()