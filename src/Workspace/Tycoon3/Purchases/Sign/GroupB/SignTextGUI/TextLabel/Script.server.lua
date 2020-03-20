repeat wait() until script.Parent.Parent.Parent.Parent.Parent.Name == "PurchasedObjects"

script.Parent.Text = "" ..script.Parent.Parent.Parent.Parent.Parent.Parent.Owner.Value.Name.. "'s Gym"