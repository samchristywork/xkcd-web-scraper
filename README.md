![Banner](https://s-christy.com/status-banner-service/xkcd-web-scraper/banner-slim.svg)

## Overview

XKCD is a web comic created by Randall Munroe mainly featuring stick figures in
a variety of funny situations. The humor is mostly nerdy with a strong emphasis
on technical jokes, and science related content.

This is an attempt to download slices of the comic for offline enjoyment.

## Running the Script

Simply execute `download_script.sh` Because the script is trivial I haven't
bothered to add command line arguments. Just change the numbers near the bottom
of the script to change behavior. The `1` is the starting value, the `100`s are
the step, and the `500` is the ending value.

Depending on the step size you selected, you will have a number of directories
in `build/` that contain "slices" of the comic. Simply open the `index.html`
file in a web browser to view that slice of the comic. Here is an example of
the contents of the `index.html` file:

```html
<div id="ctitle">Barrel - Part 1</div>
<div id="comic">
<img src="imgs/barrel_cropped_(1).jpg" title="Don&#39;t we all." alt="Barrel - Part 1"  style="image-orientation:none" />
</div>
<div id="ctitle">Petit Trees (sketch)</div>
<div id="comic">
<img src="imgs/tree_cropped_(1).jpg" title="&#39;Petit&#39; being a reference to Le Petit Prince, which I only thought about halfway through the sketch" alt="Petit Trees (sketch)"  style="image-orientation:none" />
</div>
<div id="ctitle">Island (sketch)</div>
<div id="comic">
<img src="imgs/island_color.jpg" title="Hello, island" alt="Island (sketch)"  style="image-orientation:none" />
</div>
<div id="ctitle">Landscape (sketch)</div>
<div id="comic">
<img src="imgs/landscape_cropped_(1).jpg" title="There&#39;s a river flowing through the ocean" alt="Landscape (sketch)"  style="image-orientation:none" />
</div>
<div id="ctitle">Blown apart</div>
<div id="comic">
<img src="imgs/blownapart_color.jpg" title="Blown into prime factors" alt="Blown apart"  style="image-orientation:none" />
</div>
```

## Dependencies

```
bash
curl
```

## Credits

XKCD was created by Randall Munroe.

## License

This work is licensed under the GNU General Public License version 3 (GPLv3).

[<img src="https://s-christy.com/status-banner-service/GPLv3_Logo.svg" width="150" />](https://www.gnu.org/licenses/gpl-3.0.en.html)
