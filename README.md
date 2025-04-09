# I3 Case Study: Identity Resolution from Minimal Public Signals

## Purpose

This case study explores Internet Intelligence & Investigations (I3) techniques for reconstructing identity and location from extremely limited input - sparse, unstructured public video content on YouTube.

## Objective

Assess the viability of I3 methods under information poverty.

## Methodology

### Introduction

The purpose of this case study is to demonstrate and evaluate investigative techniques in obtaining an identity and location of an individual behind a pseudonymous YouTube profile by analysing posted video and text content. The profile I chose for this purpose was selected for having sparse and minimal indicators for location and identity.

I will list the film locations in the order that I identified them along with the video and its timestamp of when the location was filmed. I will explain with each one how I obtained precise GPS coordinates.

This report is anonymised - locations, video titles, video timestamps, personal details and any other identifying information have not been included.

### Identifying Film Locations and Narrowing the Subject's Residence

1. Video A

   - A Farmers' Market ~08:10

     <div style="display: flex; gap: 20px;">
     <figure style="text-align: center;">
        <img src="images/grocery-videoA.webp" alt="Video Frame (blurred)" width="400"/>
         <figcaption>Extracted frame from Video A showing grocery storefront.</figcaption>
     </figure>
     <figure style="text-align: center;">
        <img src="images/grocery-streetview.webp" alt="Street View Match (blurred)" width="400"/>
         <figcaption>Blurred matching public image from mapping platform confirming location.</figcaption>
     </figure>
     </div>

     Reverse image searching a video frame through Yandex.com provided many results, one of which I could immediately identify to be this same building, referred to as their “local” farmers’ market in the video. This provided a foothold to begin resolving other locations in the video content.

   - A Pet Shop ~10:40

     Given the footage was filmed in a pet shop, I searched for pet shops near the rental property address I found earlier in Google Maps. Enumerating them all, I found one with user-submitted photos of the inside that matched the features in the video.

1. Video B

   - A Canyon Trail ~12:00

     After extracting a video frame looking down on a town from up on a mountain, I opened an image editing tool and highlighted key features such as roads and buildings.

     Now knowing the location where Video A was filmed, I opened Google Earth and positioned the view at, and pointing to, that town. I visually identified those features in the video frame from Video B in the software and aligned the view to point at them such that the view angle and position would make what I saw similar to the extracted video frame. This helped me identify a rough location it was filmed from the Google Earth's view position.

     Given the steepness of the mountainsides, I guessed that they would have taken a canyon trail to reach that position. I searched for the canyon trail that passed through the Google Earth's view position and opened it on Google Street View at the view position's location. I compared a Google user-submitted photo at that position to the video frame side-by-side in an image editing tool and the key features in the images and their perspectives matched which confirmed the video frame's location.

1. Video C

   - A University-owned Housing Complex ~00:40

     The footage shows the subject walking on a pavement then it cuts to them standing outside a flat complex. I searched Google Images for "apartments in [the town from previous queries]" and found a rental property listing for an address that visually matched the outside of the complex in the video. The bench's location outside the flats differed so I couldn’t be completely confident on the match however. Further research found three other similar housing complexes with a shared garden area like this in the area so I mentally noted that the footage could've also been filmed at one of the others.

   - A Softball Field ~00:30

     Now that I have the location for the more easily-identifiable scene just seconds later, I can come back to the scene of the subject walking on the pavement. As Google Street View's coverage of this area was insufficient, I searched YouTube for videos shot near the location of the housing complex in the later scene. I came across some drone footage and followed the drones path, identifying buildings it flew past by comparing them to buildings on Google Street View. With the drone's flight trajectory mapped, I could identify the location where is flies past the same portion of pavement in Video C.

1. Narrowing Residence Cluster from Prior Observations

   - Inferring the Correct Flat Complex

     In Video C, the transition from the scene of the subject walking along a pavement outside their flat complex at ~00:30 to in the shared garden area under their balcony at ~00:40 suggests they were walking home. Using mapping tools, I notated the direction of travel and with two maps of the cluster of all four flat complexes of the same type that I had found online, it could be inferred that they lived in the northern-most complex.

   - Narrowing It Down to Just Four Flats

     In Video C, there is a shot of the subject in the shared garden area from above looking down from a balcony of one of the flats. Matching the features such as trees, benches, and the playground to a satellite photo on Google Maps, I could infer that the balcony was located on the right half of the southern-most block of flats in the complex. A brown and green bench are adjacent along with an orthogonal lighter bench. These benches roughly correspond to the same near the southern-most block however the orientations and positions slightly differ in the older satellite images.

     I looked at the positions of the paths around the garden and the subject's position relative to them to identify their position on the map in the same balcony shot in Video C. This reveals roughly where the balcony is in the southern-most block of the complex.

     Overlaying a university online map over the satellite image in an image editing tool with translucency, I inferred the flat numbers that corresponded to the balcony's rough location. Google Maps doesn't show the flat numbers correctly so I looked online and found a map by the university that owns the complexes. It was a bit cryptic on how the numbers corresponded to which flats so I looked on Google Street View which showed a plaque with flat numbers on them. The numbers were ascending vertically which corresponded to the same vertically ascending numbers on the online map. This let me deduce that the balcony was located outside one of eight flats - four on floor one and four on floor two.

     If further assumptions were made, you could infer a likely flat number however such assumptions weren't convincing.

## Reflections

I've demonstrated that efforts to separate online personas from real-world identities can be insufficient against an ethical, motivated, and capable actor using only publicly accessible data - let alone a malicious one. I've learnt how powerful structured public data can be and how important operational ethics are. It also gave me practical experience with geolocation, social graph resolution, and efficient investigative tree search under uncertainty.

## Ethical Declaration

This investigation was conducted solely for research and professional development in Internet Intelligence & Investigations (I3). No private systems, credentials, or restricted data sources were accessed. All analysis was performed using publicly available information at the time of research. No contact was made with the subject or their associates. The target was treated as an anonymous case and all findings are now anonymised and disclosed only for educational purposes.

## Data Sources Used

- YouTube video uploads
  - Video content and descriptions
  - Drone footage comparisons
- File uploads
  - Colab (public notebooks)
- Image search engines
  - Yandex Reverse Image Search
  - Google Images
- Personal metadata
  - LinkedIn, Facebook (public profiles only)
  - FastPeopleSearch (US people index)
- Maps (conventional, satellite, and 3D)
  - University-provided online housing maps
  - Google Maps / Street View / Earth
