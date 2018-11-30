function doLogin() {
    if(password_id.displayText.length >=6 && username_id.displayText !== "")
    {
        var st = jsondb.isCorrect(page_rect.username_txt,page_rect.password_txt)
        if(st)
        {
            if(jsonuser_db.login(page_rect.username_txt))
            {
                if(mainStack != null)
                {
                    password_id.clear()
                    mainStack.push("qrc:/pages/LoggedInPage.qml",
                                   {jsonuser_db:json_userdetails_db,mainStack:mainStack})
                }
            }
        }
        else
        {
            dialog.text = qsTr("username or password is incorrect")
            dialog.visible = true
        }
    }
    else
    {
        dialog.text = qsTr("password must be 6 character long.\n"+
                           "And username can't be empty")
        dialog.visible = true
    }
}

function doLogout() {
    if(judb != null)
    {
        if(mainStack != null)
        {
            var user = judb.getLoggedInUser()
            judb.logout(user)
            mainStack.pop()
        }
    }
}

function createAccount() {
    if(page_rect.password_txt.length <6 || page_rect.username_txt === "")
    {
        dialog.text = qsTr("password must be 6 character long.\n"+
                           "And username can't be empty")
        dialog.visible = true
        return;
    }
    else
    {
        var st = jsondb.isUsernameAvailable(page_rect.username_txt)
        if(st)
        {
            enabled = false
            jsondb.saveNewUsernamePassword(page_rect.username_txt,
                                           page_rect.password_txt)
            enabled = true
        }
        else
        {
            dialog.text = qsTr("username already exists try diff. username")
            dialog.visible = true
        }
    }
}

function getRandomNum() {
    return Math.floor((Math.random() * 999999) + 1);
}
