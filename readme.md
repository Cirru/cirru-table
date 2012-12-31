
# Editor of Cirru, version 2

## Intro

This is rewrite of my previous project [cirru-editor][v1].  
Now it's more dependent on the structure of DOM comparing to that.  
I want to use it as a front-end component of my language toy.  

In my plan, it should be used togather with a server-side interpreter.  

[v1]: https://github.com/jiyinyiyong/cirru-editor

### Usage

A demo is available http://jiyinyiyong.github.com/cirru-editor-2/page  
It's supposed to run inside Chrome.  

I use a hidden `<input/>` tag to capture input characters.  
Press `tab` when you want to insert a blank ` `,  
press `spacebar` to make a break, and press `enter` to create blocks.  
`up down left right pgup pgdown` are the navication keys.  
Feel free to change caret's position. Though it looks not that obvious.  

If there's anything you want to suggest, please write it in the Issues.  

### Goal

I'm planning to edit my code with HTML5 UI, and save it in YAML.  
Then run it in an simple interpreter to find interests about that.  

### Reference and Thanks

SeaJS is Great, especially for us Chinese:  
http://seajs.org/

I looking forward to see the supports of parent selector in CSS4.  
It's quite painful when I can't do that with only CSS3:  
http://stackoverflow.com/questions/1014861/is-there-a-css-parent-selector

### License

MIT