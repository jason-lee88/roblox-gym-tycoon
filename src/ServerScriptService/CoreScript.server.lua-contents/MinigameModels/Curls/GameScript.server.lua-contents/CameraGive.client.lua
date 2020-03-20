camera = game.Workspace.CurrentCamera
player = game.Players.LocalPlayer

game.Workspace.CurrentCamera.CameraType = "Scriptable"
game.Workspace.CurrentCamera.CameraSubject = game.Workspace.Curls.Torso1
game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.Curls.CameraPart1.Position, game.Workspace.Curls.Torso1.Position)
player.Character:Destroy()

--script:Destroy()