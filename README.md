<div id="top">

<!-- HEADER STYLE: MODERN -->
<div align="center" style="width: 100%;">

<img src="./Kuwait Driving Test/Assets.xcassets/Logo.png" width="35%" style="display: block; margin: 0 auto;" alt="Project Logo"/>

<!-- HEADER STYLE: MODERN -->

# Kuwait Driving Test (iOS, SwiftUI)

<em><em>

<!-- BADGES -->
<img src="https://img.shields.io/github/license/tarekchaalan/KuwaitDrivingTest?style=flat&logo=opensourceinitiative&logoColor=white&color=CE1126" alt="license">
<img src="https://img.shields.io/github/last-commit/tarekchaalan/KuwaitDrivingTest?style=flat&logo=git&logoColor=white&color=CE1126" alt="last-commit">
<img src="https://img.shields.io/github/languages/top/tarekchaalan/KuwaitDrivingTest?style=flat&color=CE1126" alt="repo-top-language">
<img src="https://img.shields.io/github/languages/count/tarekchaalan/KuwaitDrivingTest?style=flat&color=CE1126" alt="repo-language-count">

<em>Built with the tools and technologies:</em>

<img src="https://img.shields.io/badge/JSON-000000.svg?style=flat&logo=JSON&logoColor=white" alt="JSON">
<img src="https://img.shields.io/badge/Swift-F05138.svg?style=flat&logo=Swift&logoColor=white" alt="Swift">

</div>
</div>
<br clear="right">

---

## Table of Contents

<details>
<summary>Table of Contents</summary>

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
    - [Project Index](#project-index)
- [Getting Started](#getting-started)
    - [Requirements](#requirements)
    - [Run](#run)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

</details>

---

## Overview

A modern, dark‑themed SwiftUI app to practice for the Kuwait driving theory exam. It includes multiple quiz modes, instant‑fail critical rules, image‑based sign questions, a Study Mode, Saved questions, and a History & Analytics view.

---

## Features

- **Quiz Modes**
  - **Standard Test** – balanced distribution (critical / true–false / image / regular)
  - **Regular Only** – non‑critical, non‑T/F, no image questions
  - **Critical Only** – critical questions (instant fail on a miss)
  - **True/False Only** – only T/F questions
  - **Images Only** – sign recognition
  - **Study Mode** – segmented filters (All, Regular, T/F, Images, Critical), reveal answers, previous/next navigation, randomize
  - **Saved** – attempts comprised only of your saved questions

- **Saved Questions**
  - Pin any question in quiz or study screens; Saved mode runs a quiz from only your saved items
  - Saved state persisted locally

- **Result History & Analytics**
  - Automatic attempt logging on quiz finish (mode, date, score, pass/fail, critical fail)
  - Summary cards: Attempts, Pass Rate, Avg Score; attempt list with badges

- **Scoring & Rules**
  - Pass threshold: **75%**
  - Any wrong **critical** question = **instant fail**

- **Design**
  - Clean **dark** look, glassy cards, gradient background
  - Accessible typography, VoiceOver hints, haptics on submission

---

## Project Structure

```sh
└── KuwaitDrivingTest/
    ├── Kuwait Driving Test
    │   ├── Assets.xcassets
    │   │   ├── 1dOvertaking.imageset
    │   │   ├── AccentColor.colorset
    │   │   ├── AllVehiclesProhibited.imageset
    │   │   ├── Ambulance.imageset
    │   │   ├── AppIcon.appiconset
    │   │   ├── Caution.imageset
    │   │   ├── Contents.json
    │   │   ├── DangerousCurves.imageset
    │   │   ├── Diamond.imageset
    │   │   ├── Disabled.imageset
    │   │   ├── DividingZone.imageset
    │   │   ├── EndNarrowRd.imageset
    │   │   ├── GiveWay.imageset
    │   │   ├── Intersection.imageset
    │   │   ├── Merge.imageset
    │   │   ├── NoEntry.imageset
    │   │   ├── NoOvertaking.imageset
    │   │   ├── NoParking.imageset
    │   │   ├── OncomingPriority.imageset
    │   │   ├── OvertakingAllowed.imageset
    │   │   ├── PedXing.imageset
    │   │   ├── RoadworkAhead.imageset
    │   │   ├── RoundaboutAhead.imageset
    │   │   ├── SchoolZone.imageset
    │   │   ├── SpeedHump.imageset
    │   │   ├── Straight.imageset
    │   │   ├── StrictlyNoParking.imageset
    │   │   ├── TrafficLightAhead.imageset
    │   │   ├── UTurnAhead.imageset
    │   │   ├── UTurnProhibited.imageset
    │   │   └── Unpaved.imageset
    │   ├── ContentView.swift
    │   ├── Data
    │   │   ├── QuestionLoader.swift
    │   │   └── Questions.json
    │   ├── Design
    │   │   ├── ConfettiView.swift
    │   │   └── Theme.swift
    │   ├── Kuwait_Driving_TestApp.swift
    │   ├── Models
    │   │   └── QuizModels.swift
    │   ├── ViewModels
    │   │   └── QuizViewModel.swift
    │   └── Views
    │       ├── HistoryView.swift
    │       ├── QuestionCard.swift
    │       ├── QuizView.swift
    │       ├── ResultView.swift
    │       └── StudyView.swift
    ├── Kuwait Driving Test.xcodeproj
    │   ├── project.pbxproj
    │   ├── project.xcworkspace
    │   │   └── contents.xcworkspacedata
    │   └── xcuserdata
    │       └── tarek.xcuserdatad
    ├── Kuwait Driving TestTests
    │   └── Kuwait_Driving_TestTests.swift
    ├── Kuwait Driving TestUITests
    │   ├── Kuwait_Driving_TestUITests.swift
    │   └── Kuwait_Driving_TestUITestsLaunchTests.swift
    ├── LICENSE
    └── README.md
```
### Project Index

<details open>
	<summary><b><code>KUWAITDRIVINGTEST/</code></b></summary>
	<!-- __root__ Submodule -->
	<details>
		<summary><b>__root__</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ __root__</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/LICENSE'>LICENSE</a></b></td>
					<td style='padding: 8px;'>- Granting users the freedom to use, modify, and distribute the software, the MIT License plays a crucial role in the projects architecture by promoting open collaboration and innovation<br>- It ensures that the software remains accessible to a wide audience while protecting the authors from liability<br>- This fosters an environment where developers can confidently build upon and integrate the software into their own projects.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- Kuwait Driving TestTests Submodule -->
	<details>
		<summary><b>Kuwait Driving TestTests</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ Kuwait Driving TestTests</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving TestTests/Kuwait_Driving_TestTests.swift'>Kuwait_Driving_TestTests.swift</a></b></td>
					<td style='padding: 8px;'>- Kuwait_Driving_TestTests.swift validates the functionality of the Kuwait Driving Test application by ensuring that the question loading mechanism operates correctly<br>- It checks that the expected number of questions is loaded, verifies the presence of critical questions, and confirms that specific images, such as Ambulance, are included<br>- This testing ensures the reliability and completeness of the question set within the application.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- Kuwait Driving TestUITests Submodule -->
	<details>
		<summary><b>Kuwait Driving TestUITests</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ Kuwait Driving TestUITests</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving TestUITests/Kuwait_Driving_TestUITests.swift'>Kuwait_Driving_TestUITests.swift</a></b></td>
					<td style='padding: 8px;'>- Conducts automated UI testing for the Kuwait Driving Test application, ensuring the apps user interface functions correctly and efficiently<br>- It sets up the initial test environment, executes tests to verify expected outcomes, and measures the apps launch performance<br>- This contributes to maintaining the app's reliability and user experience by identifying potential issues early in the development process.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving TestUITests/Kuwait_Driving_TestUITestsLaunchTests.swift'>Kuwait_Driving_TestUITestsLaunchTests.swift</a></b></td>
					<td style='padding: 8px;'>- Kuwait_Driving_TestUITestsLaunchTests.swift ensures the Kuwait Driving Test app launches correctly by automating the apps startup process and capturing a screenshot of the initial screen<br>- It verifies that the apps user interface initializes as expected, providing a foundation for further UI testing<br>- This contributes to maintaining the app's reliability and user experience by catching potential issues early in the development cycle.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- Kuwait Driving Test.xcodeproj Submodule -->
	<details>
		<summary><b>Kuwait Driving Test.xcodeproj</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ Kuwait Driving Test.xcodeproj</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test.xcodeproj/project.pbxproj'>project.pbxproj</a></b></td>
					<td style='padding: 8px;'>- The file <code>Kuwait Driving Test.xcodeproj/project.pbxproj</code> is a configuration file for the Xcode project associated with the Kuwait Driving Test application<br>- This file plays a crucial role in defining the structure and metadata of the project within the Xcode environment<br>- It manages references to the project's files, build settings, and targets, essentially serving as the backbone for how the project is organized and built<br>- This file is integral to the overall architecture as it ensures that all components of the project are correctly linked and configured, enabling developers to efficiently build and maintain the application.</td>
				</tr>
			</table>
			<!-- project.xcworkspace Submodule -->
			<details>
				<summary><b>project.xcworkspace</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.xcodeproj.project.xcworkspace</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test.xcodeproj/project.xcworkspace/contents.xcworkspacedata'>contents.xcworkspacedata</a></b></td>
							<td style='padding: 8px;'>- Defines the structure and organization of the Kuwait Driving Test project within the Xcode development environment<br>- Serves as a configuration file that helps Xcode manage the workspace, ensuring that all project files and resources are correctly linked and accessible<br>- Facilitates seamless navigation and integration of various components, contributing to efficient project management and development workflow in the broader codebase architecture.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- xcuserdata Submodule -->
			<details>
				<summary><b>xcuserdata</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.xcodeproj.xcuserdata</b></code>
					<!-- tarek.xcuserdatad Submodule -->
					<details>
						<summary><b>tarek.xcuserdatad</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.xcodeproj.xcuserdata.tarek.xcuserdatad</b></code>
							<!-- xcschemes Submodule -->
							<details>
								<summary><b>xcschemes</b></summary>
								<blockquote>
									<div class='directory-path' style='padding: 8px 0; color: #666;'>
										<code><b>⦿ Kuwait Driving Test.xcodeproj.xcuserdata.tarek.xcuserdatad.xcschemes</b></code>
									<table style='width: 100%; border-collapse: collapse;'>
									<thead>
										<tr style='background-color: #f8f9fa;'>
											<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
											<th style='text-align: left; padding: 8px;'>Summary</th>
										</tr>
									</thead>
										<tr style='border-bottom: 1px solid #eee;'>
											<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test.xcodeproj/xcuserdata/tarek.xcuserdatad/xcschemes/xcschememanagement.plist'>xcschememanagement.plist</a></b></td>
											<td style='padding: 8px;'>- Scheme management configuration in the project defines the user-specific settings for Xcode schemes, facilitating the organization and execution of build and run configurations<br>- It plays a crucial role in maintaining personalized development environments without affecting the shared project settings, ensuring that individual preferences for scheme order and visibility are preserved while collaborating on the Kuwait Driving Test application.</td>
										</tr>
									</table>
								</blockquote>
							</details>
						</blockquote>
					</details>
				</blockquote>
			</details>
		</blockquote>
	</details>
	<!-- Kuwait Driving Test Submodule -->
	<details>
		<summary><b>Kuwait Driving Test</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ Kuwait Driving Test</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Kuwait_Driving_TestApp.swift'>Kuwait_Driving_TestApp.swift</a></b></td>
					<td style='padding: 8px;'>- Defines the main entry point for the Kuwait Driving Test application, setting up the initial user interface environment using SwiftUI<br>- It initializes the apps primary window and displays the ContentView, which serves as the starting screen for users<br>- This setup is crucial for launching the app and providing a seamless user experience, aligning with the overall architecture of the project.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/ContentView.swift'>ContentView.swift</a></b></td>
					<td style='padding: 8px;'>- ContentView.swift serves as the main user interface for the Kuwait Driving Test application, providing a dynamic and interactive experience for users to practice driving test questions<br>- It manages the quiz lifecycle, allowing users to select different quiz modes and question counts, and displays results upon completion<br>- The interface also includes features for viewing quiz history and supports a consistent dark theme for enhanced user experience.</td>
				</tr>
			</table>
			<!-- Design Submodule -->
			<details>
				<summary><b>Design</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.Design</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Design/Theme.swift'>Theme.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the visual styling for the Kuwait Driving Test application, focusing on a cohesive dark theme<br>- Establishes consistent color schemes for gradients, backgrounds, and buttons, enhancing the user interfaces aesthetic appeal<br>- Provides a reusable card style modifier to ensure uniformity across UI components, promoting a seamless and visually appealing user experience throughout the app.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Design/ConfettiView.swift'>ConfettiView.swift</a></b></td>
							<td style='padding: 8px;'>- ConfettiView provides a visual celebration effect within the Kuwait Driving Test app by rendering a burst of confetti<br>- It uses SwiftUI and UIKit to create a customizable confetti animation, adjusting intensity and duration based on the <code>isPerfect</code> parameter<br>- This component enhances user experience by adding a festive touch to significant achievements or milestones, contributing to the apps engaging and interactive design.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- ViewModels Submodule -->
			<details>
				<summary><b>ViewModels</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.ViewModels</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/ViewModels/QuizViewModel.swift'>QuizViewModel.swift</a></b></td>
							<td style='padding: 8px;'>- QuizViewModel orchestrates the quiz functionality within the Kuwait Driving Test app<br>- It manages quiz modes, question selection, and user interaction, ensuring a dynamic and customizable quiz experience<br>- By tracking progress, handling user answers, and maintaining a history of attempts, it supports various quiz modes, including standard, critical, and study modes, while also providing feedback and persistence for pinned questions and quiz history.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- Assets.xcassets Submodule -->
			<details>
				<summary><b>Assets.xcassets</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.Assets.xcassets</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Contents.json'>Contents.json</a></b></td>
							<td style='padding: 8px;'>- Defines metadata for asset catalog management within the Kuwait Driving Test project<br>- It specifies the authoring tool and versioning information, ensuring compatibility and proper handling of visual assets in the Xcode environment<br>- This setup is crucial for maintaining consistency and organization of graphical resources, which supports the overall user interface design and functionality of the application.</td>
						</tr>
					</table>
					<!-- Diamond.imageset Submodule -->
					<details>
						<summary><b>Diamond.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Diamond.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Diamond.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines the image assets for the Kuwait Driving Test application, specifying different resolutions of the Diamond image for universal use across various device scales<br>- This configuration ensures that the application displays the appropriate image quality on devices with different screen resolutions, enhancing the visual consistency and user experience<br>- The asset management is handled by Xcode, as indicated by the metadata included in the file.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- TrafficLightAhead.imageset Submodule -->
					<details>
						<summary><b>TrafficLightAhead.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.TrafficLightAhead.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/TrafficLightAhead.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for a Traffic Light Ahead warning used within the Kuwait Driving Test application<br>- It specifies different image scales to ensure optimal display across various device resolutions<br>- By organizing these assets, the file contributes to the app's visual consistency and user experience, aligning with the project's goal of providing a comprehensive and realistic driving test simulation.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- NoEntry.imageset Submodule -->
					<details>
						<summary><b>NoEntry.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.NoEntry.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/NoEntry.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for a No Entry sign used within the Kuwait Driving Test application<br>- It specifies different image scales to ensure optimal display across various device resolutions, enhancing the app's visual consistency<br>- By organizing these assets, the file supports the app's user interface by providing clear, universally recognizable traffic signs, which are crucial for the educational purpose of the driving test application.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- Caution.imageset Submodule -->
					<details>
						<summary><b>Caution.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Caution.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Caution.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Caution icon used in the Kuwait Driving Test application<br>- It specifies different image scales (1x, 2x, 3x) to ensure optimal display across various device resolutions<br>- By organizing these assets, the file supports the app's visual consistency and responsiveness, contributing to a seamless user experience by adapting to different screen sizes and maintaining high-quality visuals.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- SchoolZone.imageset Submodule -->
					<details>
						<summary><b>SchoolZone.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.SchoolZone.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/SchoolZone.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the School Zone feature within the Kuwait Driving Test project<br>- It specifies different image resolutions to ensure optimal display across various device scales, enhancing the user interfaces visual consistency<br>- By organizing these assets, the file supports the applications ability to adapt to different screen sizes, contributing to a seamless and visually appealing user experience.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- RoundaboutAhead.imageset Submodule -->
					<details>
						<summary><b>RoundaboutAhead.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.RoundaboutAhead.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/RoundaboutAhead.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Roundabout Ahead sign within the Kuwait Driving Test application<br>- It specifies different image resolutions to ensure optimal display across various device scales<br>- By organizing these assets, the file contributes to the application's user interface, enhancing visual consistency and clarity for users preparing for driving tests<br>- This organization supports the app's goal of delivering an effective educational experience.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- OncomingPriority.imageset Submodule -->
					<details>
						<summary><b>OncomingPriority.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.OncomingPriority.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/OncomingPriority.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the OncomingPriority feature within the Kuwait Driving Test project<br>- It specifies different image scales to ensure optimal display across various device resolutions<br>- By organizing these assets, the file contributes to the visual consistency and user experience of the application, aligning with the project's goal of providing an intuitive and visually appealing interface for users preparing for the driving test.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- Merge.imageset Submodule -->
					<details>
						<summary><b>Merge.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Merge.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Merge.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines image assets for the Kuwait Driving Test application, specifying different resolutions for universal compatibility<br>- These assets are crucial for ensuring visual consistency across various devices by providing images at multiple scales (1x, 2x, and 3x)<br>- Managed by Xcode, the asset catalog streamlines image handling within the app, contributing to a seamless user experience by automatically selecting the appropriate image resolution based on the devices display.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- RoadworkAhead.imageset Submodule -->
					<details>
						<summary><b>RoadworkAhead.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.RoadworkAhead.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/RoadworkAhead.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Roadwork Ahead sign within the Kuwait Driving Test project<br>- It specifies multiple image resolutions to ensure optimal display across different device scales, enhancing the visual consistency of the application<br>- By organizing these assets, the project maintains a structured approach to managing graphical elements, contributing to a seamless user experience across various platforms.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- Unpaved.imageset Submodule -->
					<details>
						<summary><b>Unpaved.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Unpaved.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Unpaved.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Unpaved image set within the Kuwait Driving Test project<br>- It specifies multiple resolutions of the image to ensure optimal display across different device scales<br>- This setup is crucial for maintaining visual consistency and quality in the application's user interface, supporting both universal idioms and various screen densities, thereby enhancing the overall user experience.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- NoOvertaking.imageset Submodule -->
					<details>
						<summary><b>NoOvertaking.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.NoOvertaking.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/NoOvertaking.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the No Overtaking traffic sign within the Kuwait Driving Test project<br>- It specifies different image scales to ensure optimal display across various device resolutions<br>- By organizing these assets, the file contributes to the visual consistency and clarity of the application, enhancing the user experience by providing clear and recognizable traffic sign imagery for driving test preparation.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- AppIcon.appiconset Submodule -->
					<details>
						<summary><b>AppIcon.appiconset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.AppIcon.appiconset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/AppIcon.appiconset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines the app icons for the Kuwait Driving Test application, ensuring compatibility across various iOS devices and resolutions<br>- By specifying different icon sizes and scales for iPhones, iPads, and iOS marketing, it ensures that the apps visual identity is consistently represented across all platforms<br>- This contributes to a polished user experience and aligns with Apples design guidelines for app presentation.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- AccentColor.colorset Submodule -->
					<details>
						<summary><b>AccentColor.colorset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.AccentColor.colorset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/AccentColor.colorset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines the accent color configuration for the Kuwait Driving Test application, ensuring a consistent visual theme across different devices and screen sizes<br>- By specifying universal idiom support, it contributes to the apps adaptability and aesthetic coherence, enhancing user experience<br>- This configuration is part of the asset management system within the project, facilitating streamlined design updates and maintenance.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- AllVehiclesProhibited.imageset Submodule -->
					<details>
						<summary><b>AllVehiclesProhibited.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.AllVehiclesProhibited.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/AllVehiclesProhibited.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the All Vehicles Prohibited sign within the Kuwait Driving Test project<br>- It specifies different image resolutions to ensure compatibility across various device screens, enhancing the user interface's visual consistency<br>- By providing universal idiom support, it ensures that the application can display the appropriate image quality, contributing to a seamless user experience across all supported devices.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- EndNarrowRd.imageset Submodule -->
					<details>
						<summary><b>EndNarrowRd.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.EndNarrowRd.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/EndNarrowRd.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the End Narrow Road sign within the Kuwait Driving Test application<br>- It specifies multiple resolutions of the image to ensure compatibility across different device displays<br>- By organizing these assets, the application can dynamically render the appropriate image based on the device's screen scale, enhancing visual consistency and user experience across various platforms.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- Straight.imageset Submodule -->
					<details>
						<summary><b>Straight.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Straight.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Straight.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Straight image set within the Kuwait Driving Test project<br>- It specifies different image resolutions to ensure compatibility across various device screens, enhancing the visual consistency of the application<br>- By organizing image assets in this structured manner, the project maintains a scalable and adaptable design, crucial for delivering a seamless user experience across different platforms.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- UTurnAhead.imageset Submodule -->
					<details>
						<summary><b>UTurnAhead.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.UTurnAhead.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/UTurnAhead.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the UTurnAhead sign used in the Kuwait Driving Test application<br>- It specifies different image resolutions (1x, 2x, 3x) for universal compatibility across devices<br>- This ensures that the application displays the U-Turn Ahead sign clearly and consistently, enhancing the user interface and experience by providing the necessary visual cues for driving test scenarios.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- DangerousCurves.imageset Submodule -->
					<details>
						<summary><b>DangerousCurves.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.DangerousCurves.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/DangerousCurves.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Dangerous Curves visual element within the Kuwait Driving Test project<br>- It specifies different image resolutions to ensure optimal display across various device scales<br>- This asset management is crucial for maintaining visual consistency and quality, enhancing the user interface by providing appropriate imagery for diverse screen sizes, thereby contributing to an engaging and informative user experience.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- Ambulance.imageset Submodule -->
					<details>
						<summary><b>Ambulance.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Ambulance.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Ambulance.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- The Contents.json file in the Kuwait Driving Test project defines the image assets for an ambulance, specifying different image scales for universal use across devices<br>- It ensures that the application can display the ambulance image appropriately on various screen resolutions, contributing to a consistent and visually appealing user interface within the apps architecture.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- Disabled.imageset Submodule -->
					<details>
						<summary><b>Disabled.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Disabled.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Disabled.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Disabled state within the Kuwait Driving Test application<br>- It specifies different image resolutions to ensure optimal display across various device scales<br>- By organizing these assets, the file contributes to the application's visual consistency and accessibility, enhancing the user interface by providing appropriate imagery for different screen sizes and resolutions.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- OvertakingAllowed.imageset Submodule -->
					<details>
						<summary><b>OvertakingAllowed.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.OvertakingAllowed.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/OvertakingAllowed.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the OvertakingAllowed feature within the Kuwait Driving Test project<br>- It specifies different image resolutions to ensure compatibility across various device screens, enhancing the visual consistency of the application<br>- By managing image assets centrally, the project maintains a streamlined approach to resource handling, contributing to a cohesive user experience across all supported devices.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- 1dOvertaking.imageset Submodule -->
					<details>
						<summary><b>1dOvertaking.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.1dOvertaking.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/1dOvertaking.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the 1dOvertaking image set within the Kuwait Driving Test project<br>- It specifies multiple image resolutions to ensure compatibility across different device scales, enhancing the visual experience<br>- By organizing these assets, the file supports the project's goal of delivering a comprehensive and visually consistent driving test application, crucial for user engagement and effective learning.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- GiveWay.imageset Submodule -->
					<details>
						<summary><b>GiveWay.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.GiveWay.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/GiveWay.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Give Way sign used in the Kuwait Driving Test application<br>- It specifies different image resolutions to ensure optimal display across various devices<br>- By organizing these assets within the app's structure, it supports a consistent and scalable user interface, enhancing the visual experience and ensuring that the application adheres to design standards across all supported platforms.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- DividingZone.imageset Submodule -->
					<details>
						<summary><b>DividingZone.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.DividingZone.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/DividingZone.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the DividingZone component within the Kuwait Driving Test project<br>- It specifies different image resolutions to ensure optimal display across various device scales, enhancing the visual consistency of the application<br>- By organizing these assets, the file supports the app's user interface design, contributing to a seamless and visually appealing experience for users across all supported devices.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- SpeedHump.imageset Submodule -->
					<details>
						<summary><b>SpeedHump.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.SpeedHump.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/SpeedHump.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Speed Hump feature within the Kuwait Driving Test project<br>- It specifies multiple resolutions of the Speed Hump image to ensure optimal display across different device screens<br>- By organizing these assets, the file supports the visual consistency and adaptability of the application, contributing to a seamless user experience across various iOS devices.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- PedXing.imageset Submodule -->
					<details>
						<summary><b>PedXing.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.PedXing.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/PedXing.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the pedestrian crossing sign used in the Kuwait Driving Test application<br>- It specifies multiple image resolutions to ensure compatibility across different device screen sizes, enhancing the visual consistency and user experience<br>- By organizing these assets within the project, it supports the applications goal of providing a comprehensive and visually engaging driving test preparation tool.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- Intersection.imageset Submodule -->
					<details>
						<summary><b>Intersection.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.Intersection.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/Intersection.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Intersection component within the Kuwait Driving Test project<br>- It specifies different image resolutions to ensure compatibility across various device scales, enhancing the visual representation of intersections in the application<br>- By managing these assets, the project maintains a consistent and high-quality user interface, crucial for delivering an effective educational experience in driving test scenarios.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- UTurnProhibited.imageset Submodule -->
					<details>
						<summary><b>UTurnProhibited.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.UTurnProhibited.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/UTurnProhibited.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the UTurnProhibited sign within the Kuwait Driving Test application<br>- It specifies different image resolutions to ensure optimal display across various device screens<br>- By organizing these assets, the application can effectively present visual cues to users, enhancing the learning experience for driving test preparation<br>- This contributes to the app's goal of providing comprehensive and accessible driving education.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- NoParking.imageset Submodule -->
					<details>
						<summary><b>NoParking.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.NoParking.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/NoParking.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for a No Parking sign used within the Kuwait Driving Test application<br>- It specifies different image scales to ensure optimal display across various device resolutions<br>- By organizing these assets, the file supports the app's visual consistency and accessibility, contributing to a seamless user experience as users interact with the app's educational content on driving regulations.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- StrictlyNoParking.imageset Submodule -->
					<details>
						<summary><b>StrictlyNoParking.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Kuwait Driving Test.Assets.xcassets.StrictlyNoParking.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Assets.xcassets/StrictlyNoParking.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Contents.json defines the image assets for the Strictly No Parking sign within the Kuwait Driving Test project<br>- It specifies different image scales to ensure optimal display across various device resolutions<br>- By organizing these assets, the file contributes to the visual consistency and user interface design of the application, enhancing the user experience by providing clear and recognizable traffic signage within the app's educational context.</td>
								</tr>
							</table>
						</blockquote>
					</details>
				</blockquote>
			</details>
			<!-- Models Submodule -->
			<details>
				<summary><b>Models</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.Models</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Models/QuizModels.swift'>QuizModels.swift</a></b></td>
							<td style='padding: 8px;'>- Define the structure and logic for managing quiz questions and results within the Kuwait Driving Test application<br>- It includes models for quiz questions, results, and attempts, supporting features like question identification, answer validation, and tracking quiz progress<br>- The models facilitate decoding from data sources and ensure accurate representation of quiz states, contributing to the overall functionality of the quiz component in the application.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- Data Submodule -->
			<details>
				<summary><b>Data</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.Data</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Data/QuestionLoader.swift'>QuestionLoader.swift</a></b></td>
							<td style='padding: 8px;'>- QuestionLoader serves as a utility within the Kuwait Driving Test application to retrieve and decode quiz questions from a JSON file<br>- It ensures that the questions are correctly loaded into the apps environment, facilitating the seamless integration of quiz content<br>- By managing data retrieval and error handling, it supports the applications core functionality of delivering driving test quizzes to users.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Data/Questions.json'>Questions.json</a></b></td>
							<td style='padding: 8px;'>- The <code>Questions.json</code> file within the Kuwait Driving Test project serves as a repository of questions designed to simulate the theoretical portion of a driving test<br>- This JSON file contains a structured collection of multiple-choice questions, each with a unique identifier, the question text, possible answers, and the index of the correct answer<br>- The questions are aimed at assessing the user's knowledge of driving rules and regulations, which is crucial for preparing candidates for the actual driving test<br>- By providing a diverse set of questions, this file plays a critical role in the project's goal to offer a comprehensive and realistic practice environment for aspiring drivers.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- Views Submodule -->
			<details>
				<summary><b>Views</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Kuwait Driving Test.Views</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Views/QuestionCard.swift'>QuestionCard.swift</a></b></td>
							<td style='padding: 8px;'>- QuestionCard.swift defines a SwiftUI view component that displays a quiz question card for the Kuwait Driving Test app<br>- It presents the question text, potential answers, and highlights critical questions<br>- Users can select answers and pin questions for later review<br>- The component enhances user interaction by providing visual cues and accessibility features, contributing to an engaging and informative quiz experience within the app.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Views/ResultView.swift'>ResultView.swift</a></b></td>
							<td style='padding: 8px;'>- ResultView in the Kuwait Driving Test app provides a user interface for displaying quiz results<br>- It visually communicates whether the user passed or failed, highlights perfect scores with confetti, and offers options to restart or retake the quiz<br>- The view enhances user experience with dynamic feedback and accessibility features, ensuring users receive clear, motivational guidance based on their performance.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Views/QuizView.swift'>QuizView.swift</a></b></td>
							<td style='padding: 8px;'>- QuizView.swift provides the user interface for the quiz functionality within the Kuwait Driving Test app<br>- It manages the display of questions, tracks user progress, and handles interactions such as selecting answers and navigating through the quiz<br>- The view adapts based on the quiz mode, offering study and saved question modes, and includes features like exit alerts and score tracking to enhance the user experience.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Views/HistoryView.swift'>HistoryView.swift</a></b></td>
							<td style='padding: 8px;'>- HistoryView serves as a user interface component within the Kuwait Driving Test app, providing users with a detailed overview of their quiz attempts<br>- It displays analytics such as the number of attempts, pass rate, and average score<br>- The view also lists individual quiz attempts, highlighting details like the mode, date, score, and pass/fail status, enhancing user engagement and feedback on performance.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/tarekchaalan/KuwaitDrivingTest/blob/master/Kuwait Driving Test/Views/StudyView.swift'>StudyView.swift</a></b></td>
							<td style='padding: 8px;'>- StudyView.swift provides an interactive interface for users to engage with quiz questions in the Kuwait Driving Test application<br>- It allows users to filter questions by type, view questions with or without images, and navigate through them using a flashcard-style format<br>- Users can also pin questions for later review, toggle answer visibility, and seamlessly switch between different question categories to enhance their study experience.</td>
						</tr>
					</table>
				</blockquote>
			</details>
		</blockquote>
	</details>
</details>

---

## Getting Started

### Requirements

- Xcode 15+
- iOS 17+ (Simulator or device)
- Swift 5.9+

### Run

1. Open `Kuwait Driving Test.xcodeproj` in Xcode
2. Select a simulator (e.g., iPhone 15)
3. Run ▶︎

---

## Roadmap

- Categories / tags per question
- Share sheet for results
- iCloud sync for Saved and History

---

## Contributing

- **💬 [Join the Discussions](https://github.com/tarekchaalan/KuwaitDrivingTest/discussions)**: Share your insights, provide feedback, or ask questions.
- **🐛 [Report Issues](https://github.com/tarekchaalan/KuwaitDrivingTest/issues)**: Submit bugs found or log feature requests for the `KuwaitDrivingTest` project.
- **💡 [Submit Pull Requests](https://github.com/tarekchaalan/KuwaitDrivingTest/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/tarekchaalan/KuwaitDrivingTest
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="left">
   <a href="https://github.com{/tarekchaalan/KuwaitDrivingTest/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=tarekchaalan/KuwaitDrivingTest">
   </a>
</p>
</details>

---

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.


<div align="right">

[![][back-to-top]](#top)

</div>


[back-to-top]: https://img.shields.io/badge/-BACK_TO_TOP-151515?style=flat-square


---
