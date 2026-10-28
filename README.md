# Firefox theme for Omarchy

A Firefox theme for [Omarchy](https://omarchy.org) 4. It follows whichever Omarchy theme is active, with square corners everywhere and the Omarchy font.

Based on [firefox-gnome-theme](https://github.com/rafaelmardojai/firefox-gnome-theme) by Rafael Mardojai CM, which started from Luna Kurame's original Adwaita theme for Firefox. See [Credits](#credits).

## Features

- **Follows the Omarchy theme.** `omarchy/firefox.css.tpl` is an Omarchy template, so `omarchy theme set` renders the theme's `colors.toml` to `~/.local/state/omarchy/current/theme/firefox.css`, which is linked into the Firefox profile. The browser UI and Firefox's own pages (Settings, Add-ons, New Tab) use those colors, and light themes switch Firefox to light mode. Without the generated file, a Gruvbox palette is used.
- **Square corners** on tabs, the URL bar, buttons, menus, popups and dialogs.
- **Omarchy font.** The UI uses fontconfig's `monospace`, which `omarchy font set` changes (JetBrains Mono by default).
- **No window buttons.** Hyprland manages the window; close it with Super+W.

Firefox only reads its CSS at startup, so restart it after switching Omarchy themes.

Supports the current Firefox stable release, `158`.

## Installation

```sh
git clone https://github.com/chayotesudado/firefox-theme-omarchy.git
cd firefox-theme-omarchy
./scripts/omarchy-install.sh
```

The script:

1. Installs the theme into every profile in `~/.config/mozilla/firefox` (via `scripts/install.sh`).
2. Copies the template to `~/.config/omarchy/themed/firefox.css.tpl`.
3. Renders the colors for the current Omarchy theme.
4. Links them into each profile as `chrome/firefox-gnome-theme/theme/omarchy/generated.css`.

Options:

- `-f <firefox_folder_path>`: use another Firefox folder, for example `~/.var/app/org.mozilla.firefox/.mozilla/firefox` for Flatpak.
- `-p <profile_name>`: only install into one profile, for example `pc8577yz.default-release`.

Then restart Firefox.

### Customizing

- **Font size:** the URL bar and tab titles are set to `0.9em` in `theme/omarchy/font.css`.
- **Colors:** the mapping from Omarchy colors to the theme is in `theme/omarchy/colors.css`.

Edit the files in the repo and run `./scripts/omarchy-install.sh` again. For changes that should survive updates, put them in `customChrome.css` or `customContent.css` in the repo root (both are git-ignored and imported last).

## Updating

```sh
git pull
./scripts/omarchy-install.sh
```

## Required Firefox preferences
We provide a **user.js** configuration file in `configuration/user.js` that enables some preferences required by this theme to work.

You should already have this file installed if you followed one of the installation methods, but in any case be sure this preferences are enabled under `about:config`:

- `toolkit.legacyUserProfileCustomizations.stylesheets`

	This preference is required to load the custom CSS in Firefox, otherwise the theme wouldn't work.

- `svg.context-properties.content.enabled`

	This preference is required to recolor the icons, otherwise you will get black icons everywhere.

> For other non essential preferences checkout `configuration/user.js`.

## Uninstalling
1. Go to your profile folder. (Go to `about:support` in Firefox > Application Basics > Profile Directory > Open Directory)
2. Remove the `chrome` folder.
3. Remove the unwanted preferences from your `user.js` inside your profile folder. The install script appends the preferences listed in `configuration/user.js`.
4. Remove `~/.config/omarchy/themed/firefox.css.tpl`.

## Enabling optional features
Optional features can be enabled by creating new `boolean` preferences in `about:config`.

1. Go to the `about:config` page
2. Type the key of the feature you want to enable
3. Set it as a `boolean` and click on the add button
4. Restart Firefox

### Optional features

- **Hide single tab** `gnomeTheme.hideSingleTab`

	Hide the tab bar when only one tab is open.

	> **Note:** You should move the new tab button out of the tabbar or it will be hidden when there is only one tab. You can rearrange the toolbars doing a right-click on any toolbar and selecting "Customize Toolbar…".

- **Normal width tabs** `gnomeTheme.normalWidthTabs`

	Use normal width tabs as default Firefox.

- **Swap tab close button position** `gnomeTheme.swapTabClose`

	Move the tab close button to the other side of the tab.

- **Bookmarks toolbar under tabs** `gnomeTheme.bookmarksToolbarUnderTabs`

	Move Bookmarks toolbar under tabs.

- **Active tab contrast** `gnomeTheme.activeTabContrast`

	Add more contrast to the active tab.

- **Close only selected tabs** `gnomeTheme.closeOnlySelectedTabs`

	Show the close button on the selected tab only.

- **System icons** `gnomeTheme.systemIcons`

	Use system theme icons instead of Adwaita icons included by theme.

	> **Note:** This feature has a [known color bug](#icons-color-broken-with-system-icons).


- **No themed Icons** `gnomeTheme.noThemedIcons`

	Use default Firefox icons instead of the included icons.


- **Symbolic tab icons** `gnomeTheme.symbolicTabIcons`

	Make all tab icons look kinda like symbolic icons.

- **Hide WebRTC indicator** `gnomeTheme.hideWebrtcIndicator`

	Hide the WebRTC sharing indicator.

- **Blank private browsing page** `gnomeTheme.blankPrivateBrowsingPage`

	Show a blank page instead of the "You're off the record" intro when opening a private window.

- **Hide unified extensions button** `gnomeTheme.hideUnifiedExtensions`

	Hide unified extensions button from the navbar, you can also use `extensions.unifiedExtensions.enabled` instead, which is only going to work till Firefox 111.

- **Drag window from headerbar buttons** `gnomeTheme.dragWindowHeaderbarButtons`

	Allow dragging the window from headerbar buttons.

	> **Note:** This feature is BUGGED. It can activate the button with unpleasant behavior.

- **Tabs as headerbar** `gnomeTheme.tabsAsHeaderbar`

	Place the tabs on the top of the window, and use the tabs bar to hold the window controls, like Firefox's standard tab bar.
	
	> **Note:** Enabling with `gnomeTheme.hideSingleTab` will replace the single tab with a title bar.

- **Show "List All Tabs" button on overflow** `gnomeTheme.allTabsButtonOnOverflow`

	Show the `List All Tabs` button when the tabs bar is overflowing (when you have too many tabs that the width of the tabs no longer shrinks when new tabs are added).

- **Show "List All Tabs" button** `gnomeTheme.allTabsButton`

	Show the `List All Tabs` button all the time, like stock Firefox.
    
- **Align tab title and icon to left** `gnomeTheme.tabAlignLeft`

	Align the tab title and favicon to left of tab in place of center.
	
- **Bookmarks bar in fullscreen** `gnomeTheme.bookmarksOnFullscreen`

	 Show the bookmarks bar while in fullscreen.

## Development

If you wanna mess around the styles and change something, you might find these
things useful.

To use the Inspector to debug the UI, open the developer tools (F12) on any
page, go to options, check both of those:

- Enable browser chrome and add-on debugging toolboxes
- Enable remote debugging

Now you can close those tools and press Ctrl+Alt+Shift+I to Inspect the browser
UI.

## Credits

This theme stands on the work of:

- **[Luna Kurame](https://github.com/lunakurame/firefox-gnome-theme)**, who created the original GNOME/Adwaita theme for Firefox.
- **[Rafael Mardojai CM](https://github.com/rafaelmardojai)** and the [firefox-gnome-theme contributors](https://github.com/rafaelmardojai/firefox-gnome-theme/graphs/contributors), who developed and maintain [firefox-gnome-theme](https://github.com/rafaelmardojai/firefox-gnome-theme), which this repo is forked from. Its full history is kept here.

Colors come from the active [Omarchy](https://omarchy.org) theme.

Released into the public domain under the [Unlicense](LICENSE), like the original.
