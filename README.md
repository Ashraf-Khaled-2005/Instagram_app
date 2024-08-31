# Instagram-Like App

## Overview

This Flutter application emulates key features of Instagram, providing users with a social media experience that includes authentication, user profiles, posts, stories, and real-time chat. The app leverages Firebase for backend services and Cloud Storage for handling user images.

## Features

- **Firebase Authentication**:
  - Users can sign up and log in using their email and password.
  - Supports secure user registration and login.

- **User Profile**:
  - Users can upload and update their profile picture.
  - Manage their username and other profile details.

- **Search and Follow**:
  - Users can search for other users.
  - Follow and unfollow other users.

- **Posts**:
  - Users can create, view, and delete posts.
  - Add comments to posts.

- **Stories**:
  - Users can create and view stories.
  - Stories automatically delete after 24 hours.

- **Chat**:
  - Real-time messaging between users using Firebase Cloud Firestore.

- **Firebase Cloud Storage**:
  - Store and manage user profile pictures and post images.

- **App Icon Change**:
  - Customize the app icon as needed.

## Technical Details

- **Flutter**: The app is developed using Flutter for a cross-platform mobile experience.

- **Firebase Authentication**:
  - Manages user authentication and session state with email and password.

- **Cloud Firestore**:
  - Real-time database used for storing user data, posts, comments, and chat messages.

- **Firebase Cloud Storage**:
  - Used to store and manage user profile pictures and post images.

- **Automatic Story Deletion**:
  - Stories are automatically deleted after 24 hours using Firebase functions or scheduled tasks.

- **App Icon Change**:
  - The app includes functionality to change the app icon.

## Installation

1. Clone the repository:
   ```bash
   git clone <https://github.com/Ashraf-Khaled-2005/Instagram_app.git>
