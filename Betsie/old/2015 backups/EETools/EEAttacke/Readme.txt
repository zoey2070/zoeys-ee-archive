#######################################
# You use this program at your own risk. 
# And I am in no way to be held responsible for any damage that happens, 
# from use of this program. even if it is blatantly my fault.
#
# If you find any viruses in the files, it's just false positives.
########################################

########################################
You need to do this before anything
########################################

1. Choose a browser and join EE and a room that is password protected.
2. Run GetClass.exe.
3. Look inside eecracker.ini for "yourbrowser=string", if you can find it go to 5.
4. Copy the text inside the password field and add "yourbrowser=text" inside the ini-file. 
It should look like "Firefox=GeckoPluginWindow1"

5. It's done. Sometimes do you need to do this if the class changes or the instance.
This is going to be automatic later. It's still not done.

#####################################
Change the settings in eecracker.ini
#####################################

1 = On / 0 = Off

log = Logging all events, testing words and errors.

####### Bruteforce program, crackfromx_to_y ###########

Mode need to be 2, or else this will not work.

len1 = 100, From number x
len2 = 400, To number y

####### Wordlist / Dictionary Attack ###########

IMPORTANT: The Hybrid Attack isn't added yet.

This is the words that the program is testing against the code field.
You can use numbers and words. Numbers such as 1-100 can you take
with the bruteforce. You don't need to add lowercase and uppercase
of the same word. Use the Hybrid attack instead.

A good tool to remove duplicates is Dupekill. You can find it at the Internet.
And one more thing. Don't use big wordlists, because it will take long time to use the dict attack,
if you use Hybrid Attack at the same time.

######### How to run ##########

(Don't close the browser/tab while it cracking)

F2 - Starting the Wordlist attack.  (EEAttacker)
F3 - Starting the bruteforce attack. (EEAttacker, EECracker and crackfromx_to_y)

############################

Use VPN when cracking.
Don't use proxies, because the webbrowser can't handle proxies through flash.

Homepage: http://www.mrdelightkid.110mb.com
Youtube: http://www.youtube.com/user/mrdelightkid