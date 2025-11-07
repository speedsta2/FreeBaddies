while true do
    -- all 3 label locations
    local labels = {
        game.Workspace.GasStation.Util.HealthGui.Label,
        game.Workspace.RespectBoard.Title.SurfaceGui.Title,
        game.Workspace.Gym.GUI.Screen.Frame.Status,
        game.Players.LocalPlayer.PlayerGui.GeneralGUI.PvPWarning.warning
    }

    -- enable RichText for all
    for _, label in ipairs(labels) do
        label.RichText = true
    end

    -- helper function to update all labels together
    local function setText(txt)
        for _, label in ipairs(labels) do
            label.Text = txt
        end
        task.wait(0.67)
    end

    -- Type "CopeRevamped"
    setText("<b>C</b>")
    setText("<b>Co</b>")
    setText("<b>Cop</b>")
    setText("<b>Cope</b>")
    setText("<b>CopeR</b>")
    setText("<b>CopeRe</b>")
    setText("<b>CopeRev</b>")
    setText("<b>CopeReva</b>")
    setText("<b>CopeRevam</b>")
    setText("<b>CopeRevamp</b>")
    setText("<b>CoperRevampe</b>")
    setText("<b>CopeRevamped</b>")
    setText("<b>CopeRevamped</b>\n o")
    setText("<b>CopeRevamped</b>\n on")
    setText("<b>CopeRevamped</b>\n on D")
    setText("<b>CopeRevamped</b>\n on Di")
    setText("<b>CopeRevamped</b>\n on Dis")
    setText("<b>CopeRevamped</b>\n on Disc")
    setText("<b>CopeRevamped</b>\n on Disco")
    setText("<b>CopeRevamped</b>\n on Discor")
    setText("<b>CopeRevamped</b>\n on Discord")
    setText("<b>CopeRevamped</b>\n on Discord!")

    -- Color cycle
    local colors = {
        "#ffb6c1", -- light pink
        "#add8e6", -- light blue
        "#8b0000", -- dark red
        "#ffff00", -- yellow
        "#32cd32"  -- lime green
    }

    for _, color in ipairs(colors) do
        local txt = string.format('<b><font color="%s">CoperRevamped</font></b>\n on Discord!', color)
        for _, label in ipairs(labels) do
            label.Text = txt
        end
        task.wait(0.67)
    end

    task.wait(1)

    -- Reverse delete animation
    local reverseTexts = {
        "<b>CopeRevamped</b>\n on Discord",
        "<b>CopeRevamped</b>\n on Discor",
        "<b>CopeRevamped</b>\n on Disco",
        "<b>CopeRevamped</b>\n on Disc",
        "<b>CopeRevamped</b>\n on Dis",
        "<b>CopeRevamped</b>\n on Di",
        "<b>CopeRevamped</b>\n on D",
        "<b>CopeRevamped</b>\n on",
        "<b>CopeRevamped</b>\n o",
        "<b>CopeRevampe</b>",
        "<b>CopeRevamp</b>",
        "<b>CopeRevam</b>",
        "<b>CopeReva</b>",
        "<b>CopeRev</b>",
        "<b>CopeRe</b>",
        "<b>CopeR</b>",
        "<b>Cope</b>",
        "<b>Cop</b>",
        "<b>Co</b>",
        "<b>C</b>",
        ""
    }

    for _, txt in ipairs(reverseTexts) do
        for _, label in ipairs(labels) do
            label.Text = txt
        end
        task.wait(0.67)
    end

    task.wait(1)
end
