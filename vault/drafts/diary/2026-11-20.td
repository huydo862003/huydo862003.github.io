---
_type: DiaryEntry
_label: "2026-11-20: A new home for my diary - The start of a 4-day holiday"
date: "2026-11-20"
mood: "neutral"
written_at: "23:59"
---

Dear diary,

Today was a special day: Vietnam's National Teacher Day and also the last working day of the week, towards the 4-day holiday due to the next Vietnam's National Culture Day (at least that's what I supposed it should be called as) on November 24 (actually I'm intending to apply for an annual leave on November 23, hence the 4 days).

So I was woken up at about 8 a.m this morning. My brother was urging me to go to work but I decided to request a work-from-home. I went back to sleep shortly after that then went on to open laptop. As I was going on a diet, I didn't have breakfast.

There was a lot of things to do! Or so I thought in the morning. At about 9 a.m, I was working and thinking about what to wish to my teachers.

I opened up the chat for Mr. Hudro, Mr. Hopps, Ms. Vanise but couldn't work out anything special. I'll come up with something anyways! I thought to myself & started working.

I was reviewing the PR to support SCIM, an SSO extension for my colleague. So far, I didn't find any issues then. Until recently, I found that I hadn't reflected upon how I was reviewing PRs lately. Usually, I was just skimming and approved, as there were floods of PRs opened to me, and most of them seem AI-generated! My load was very high, however, I wasn't going that to dull my reviewing skills. For SCIM especially, I drafted a doc about all the behaviors that the user should observe to do an UAT. I also made a list of edge cases the system must handle. Then, I broke down which part of the code would be affected. Doing this, I realized one thing:

> Reading the design doc alone didn't make me feel confident enough that I wouldn't miss anything during the review. Instead, I wrote down: what to expect from the users' POVs & which parts of the system should be touched. Then, I went over the design doc once again and compare with what I wrote down to see if I missed anything. This helped me create "my own mental model of the design"!

One thing I realized when I wrote this diary entry: I had never cared to make a check list of other non-functional requirements:

- Performance.
- Robustness/Reliability.
- Security.

Usually, I would focus on maintainability and code organization only.

Okay, back to the review, so I didn't find anything special, beside the problem that has been plaguing our codebase: Utility functions everywhere, too many ways of doing 1 thing, and leaky abstractions.

Then, I did go back and sent Mr. Hudro a wish. He then thanked me shortly after that. He did jokingly asked me to go back and teach his students some national mathematics problems, to which I said I wouldn't recall any of those knowledge. He sent a sticker and just said OK :P Well, as always, Mr. Hudro is a bit too plain and dry. However, I have always held him close to my heart.

At noon break, me and my mom went to the food store right next to my appartment building to eat. Today's rice portion was unusually larger than other days' & we're especially full.

In the afternoon, I managed to send two messages to my other teachers. They didn't thank me until late afternoon.

My work spirit was a bit low, so I just did some cursory self-review on the dbdiagram CLI migration PR. There was a bug report to the dbdiagram sidebar from Thea, but I just delegated to Nager. I was exhausted! The higher-level engineers had been delegating tasks to me, which were pretty annoying. Most of them felt like errands... And they weren't even holding any significant tasks. This is a bad culture of the team...

Anyways, after work, I had dinner, went on for a walk with my mom, had a nice avocado ice cream at a reasonable price at the same food store and went home.

From then until just now, I had been reading about vector databases to work on oriondb.

That's all for today...

---

Dear diary, I have some feelings to share...

I have been feeling very nostalgic recently. At night, my mind often transported me back to different times of the past. From when I was at elementary school, to when I was watching "Truth or dare" with my friends when we went on a mathematical camps in Quang Binh (now Quang Tri), to when I was a fresher at my university, to when I was at Saigon Gateway with my unexpected roomates. I realized so much time has passed, and my brain wouldn't have the capacity to keep all these memories forever. I wondered when I got old, would I be yearning for those days, but struggling to recall any of these... Therefore, I decided to continue my diary... And I realized I want to focus on my thought process, besides the daily routines...

Yesterday was the day I read the lyrics and saw the MV for "Army Dreamers" of Kate Bush. I'm not usually a humanitarian, but that song somehow touched me. Kate Bush is such a genuine and eccentric artist. Somehow, I felt really sad that she was then 68. I then pondered about the possibility of the world never heard Kate Bush new songs/production/vocal performances again... I know that is silly, but this was always what I've been feeling.
