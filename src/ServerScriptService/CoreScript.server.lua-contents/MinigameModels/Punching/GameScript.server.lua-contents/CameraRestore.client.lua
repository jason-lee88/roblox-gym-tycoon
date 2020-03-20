camera = game.Workspace.CurrentCamera
player = game.Players.LocalPlayer

camera.CameraType = "Custom"
camera.CameraSubject = player.Character.Humanoid

--script:Destroy()