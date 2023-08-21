# ``Friends``

An app to search and view for users and content from API such as GitHub and iTunes.

## Overview

Friends is an iOS app that allows users to search content from API.
There are two API services:
- Apple search API (iTunes)
- GitHub search API (Users)

As a result we get a bunch of ``GithubRecord``s or ``ITunesRecord``s depending what we a looking for.

@Row {
    @Column {
        ![An illustration displaying the UI for finding of contents on GitHub.](github.png)
    }
    
    @Column {
        ![An illustration displaying the UI for finding of contents on iTunes.](itunes.png)
    }
}


### Features

- You can expand an icon to full screen.

@Video(poster: "preview", source: "preview", alt: "An animated video.")


## Topics

### Essentials

- ``GithubRecord``
- ``ITunesRecord``
- ``RecordsViewModel``

### Decoding data
- ``GithubDecoder``
- ``ITunesDecoder``

### API service
- ``DataProvider``
