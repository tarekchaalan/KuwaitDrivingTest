# 🇰🇼 Kuwait Driving Test (iOS, SwiftUI)

A modern, dark-themed SwiftUI app to practice for the Kuwait driving theory exam.
Features multiple quiz modes, instant-fail critical questions, images for signs, and a Study Mode for flashcard-style review.

---

## ✨ Features

- **Quiz Modes**
  - **Standard Test** – balanced distribution (critical / true–false / image / regular).
  - **Regular Only** – non-critical, non-T/F, no image questions.
  - **Critical Only** – critical questions (instant fail on a miss).
  - **True/False Only** – only T/F questions.
  - **Images Only** – sign recognition.
  - **Study Mode** – filter by All, T/F, Images, Critical; reveal answers; previous/next navigation; randomize.

- **Scoring & Rules**
  - Pass threshold: **75%**.
  - Any wrong **critical** question = **fail immediately**.
  - Fine-grained progress and score HUD.

- **Design**
  - Clean **dark** look, glassy cards, gradient background.
  - Accessible typography, VoiceOver hints, haptics on answer submission.

---

## 🧱 Architecture

- **UI**: SwiftUI
- **Pattern**: MVVM
- **Data**: Local JSON (`Questions.json`)
- **Haptics**: `UINotificationFeedbackGenerator`
- **Testing**: Swift `Testing` (and XCUITest scaffolding)

```

Kuwait Driving Test/
├── ContentView\.swift                  # Entry screen + mode picker
├── Kuwait\_Driving\_TestApp.swift      # @main
├── Design/Theme.swift                  # Dark gradient + card/background helpers
├── Data/
│   ├── Questions.json                  # Question bank (170 items)
│   └── QuestionLoader.swift            # JSON decode loader
├── Models/QuizModels.swift             # QuizQuestion, QuizResult, QuizState
├── ViewModels/QuizViewModel.swift      # Quiz engine + modes + scoring
└── Views/
├── QuestionCard.swift                  # Question UI + answers
├── QuizView\.swift                     # Quiz flow, header, submit/next
├── ResultView\.swift                   # Pass/Fail summary
└── StudyView\.swift                    # Flashcard-style browsing

````

---

## 🔢 Question JSON Schema

Each item in `Questions.json`:

```json
{
  "id": 1,
  "text": "Question text",              // Question
  "answers": ["A", "B", "C", "D"],      // Answer choices
  "correctIndex": 2,                    // Correct Answer
  "imageName": "NoParking",             // or null
  "isCritical": false,                  // true for critical questions
  "tf": false                           // true for T/F items
}
````

> Notes
>
> * `tf` is a plain boolean field (your model also tolerates a `"T/F"` key if present).
> * `imageName` must match an entry in **Assets.xcassets** (e.g., `Ambulance`).

---

## 🧮 Distribution Logic (Standard Mode)

In `QuizViewModel.startStandardQuiz()` the selected count `n` is split as:

* **Critical**: `round(0.05 * n)`
* **True/False**: `round(0.15 * n)`
* **Images**: `round(0.25 * n)`
* **Regular**: remainder

The final set is shuffled.

---

## 🚀 Getting Started

**Requirements**

* Xcode 15+
* iOS 17+ (Simulator or device)
* Swift 5.9+ (SwiftUI)

**Run**

1. Open `Kuwait Driving Test.xcodeproj` in Xcode.
2. Select a simulator (e.g., iPhone 15).
3. **Run** ▶︎.

**Assets**

* Place sign images (e.g., `Ambulance.jpg`) inside `Assets.xcassets`.
* Make sure names in JSON match asset names exactly (case-sensitive).

---

## 🧪 Tests

### Run All Tests

* In Xcode: **Product → Test** (⌘U)

### Unit Test Example

`Kuwait Driving TestTests/Kuwait_Driving_TestTests.swift`:

```swift
import Testing
@testable import Kuwait_Driving_Test

struct Kuwait_Driving_TestTests {
    @Test func testQuestionsLoad() async throws {
        let qs = QuestionLoader.load()
        #expect(qs.count == 170)
        #expect(qs.contains { $0.isCritical })
        #expect(qs.contains { $0.imageName == "Ambulance" })
    }
}
```

> If you see issues with the `Testing` package on older Xcode toolchains, switch to `XCTest`:
>
> ```swift
> import XCTest
> @testable import Kuwait_Driving_Test
> final class Kuwait_Driving_TestTests: XCTestCase {
>   func testQuestionsLoad() {
>     let qs = QuestionLoader.load()
>     XCTAssertEqual(qs.count, 170)
>     XCTAssertTrue(qs.contains { $0.isCritical })
>     XCTAssertNotNil(qs.first { $0.imageName == "Ambulance" })
>   }
> }
> ```

---

## 🎮 Usage Walkthrough

1. **Home**: pick number of questions (20–170).
2. Choose **Standard** or a **Specialized Mode** (Regular / T-F / Images / Critical / Study).
3. During quiz:
   * Select an answer → **Next/Finish**.
   * Wrong **critical** answer → instant fail, and end.
4. **Results**: see score, pass/fail, passing threshold, and retake options.
5. **Study Mode**: segmented control (All, T/F, Images, Critical), reveal answers, randomize, previous/next.

---

## 🗺️ Roadmap Ideas

* Bookmarked questions
* Categories / tags per question
* Result history & analytics
* Share sheet for results

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.