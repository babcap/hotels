//
//  HotelsDataManager.swift
//  hotels
//
//  Created by Arthur on 25.02.2024.
//

import UIKit

struct HotelsArticleViewModel {
    let image: UIImage
    let description: String
}

final class HotelsDataManager {
    private init() {}
    static let shared = HotelsDataManager()
}

extension HotelsDataManager {
    var HotelsWelcomeArticleTitle: String {
        return "Welcome"
    }

    var HotelsWelcomeArticleDesctiption: String {
        return "to our weekend hotel blog, where we uncover the secrets to the perfect weekend getaway. Whether you're looking for luxury escapes, budget-friendly stays, or unique experiences, we're here to guide you through the world of weekend hospitality. Join us as we explore hidden gems, share insider tips, and provide inspiration for making the most of your time away from home. Get ready to indulge in relaxation, adventure, and unforgettable moments as we embark on weekend adventures together. Welcome to your ultimate weekend hotel guide!"
    }

    var HotelsWelcomeArticle: HotelsArticleViewModel {
        .init(image: UIImage(named: "ic_article_welcome")!,
              description: "\(HotelsWelcomeArticleTitle) \(HotelsWelcomeArticleDesctiption)")
    }

    var HotelsMainArticle: HotelsArticleViewModel {
        return .init(image: UIImage(named: "ic_article_main")!,
                     description: """
                     Resting by the sea offers a rejuvenating escape from the hustle and bustle of daily life. There's something inherently calming about the rhythm of the waves, the salty breeze, and the vast expanse of the horizon stretching out before you.
                     As you settle into a comfortable spot on the sandy shores, the stresses of the week begin to melt away. The gentle lullaby of the ocean waves acts as a natural tranquilizer, easing tension from your mind and body. With each breath of fresh sea air, you feel yourself becoming more present, more mindful of the beauty that surrounds you.
                     Resting by the sea is not just about physical relaxation; it's also about nourishing your soul. There's a profound sense of serenity that comes from gazing out at the endless expanse of water, reminding you of the vastness of the world and the infinite possibilities it holds.
                     Whether you choose to bask in the warmth of the sun, take a leisurely stroll along the shoreline, or simply sit and watch the waves dance upon the sand, every moment spent by the sea is an opportunity to replenish your spirit.
                     In today's fast-paced world, it's more important than ever to carve out time for rest and rejuvenation. And what better place to do so than by the sea, where nature's soothing embrace offers solace to weary souls? So next time you're in need of a break, consider heading to the coast and letting the healing power of the sea wash over you.
                     """)
    }

    var HotelsFirstArticle: HotelsArticleViewModel {
        return .init(image: UIImage(named: "ic_article_first")!,
                     description: """
                     Taking a leisurely walk around the city is an invitation to explore the heartbeat of urban life at a relaxed pace. It's a chance to slow down, observe the details, and immerse yourself in the sights, sounds, and smells that define a place.
                     As you meander through the streets, you'll discover hidden gems tucked away in unexpected corners. Perhaps it's a cozy café with sidewalk tables spilling onto the pavement, tempting you with the aroma of freshly brewed coffee. Or maybe it's a quaint bookstore, its shelves lined with stories waiting to be discovered.
                     The beauty of a leisurely city walk lies in its spontaneity. There's no need for a map or an itinerary – simply follow your curiosity and see where it leads you. You might stumble upon colorful street art adorning brick walls, or stumble upon a bustling farmers' market filled with local produce and handmade goods.
                     But it's not just the sights that make a leisurely city walk so enjoyable – it's also the sounds and sensations that surround you. The hum of traffic, the chatter of passersby, the distant strains of music drifting from open windows – all of these create a symphony of urban life that's both energizing and comforting.
                     And let's not forget about the physical benefits of walking. Not only does it provide a gentle form of exercise, but it also allows you to experience the city in a more intimate way, engaging all of your senses as you move through its streets.
                     So the next time you find yourself with some free time and a desire to unwind, consider taking a leisurely walk around the city. You'll be amazed at what you discover when you slow down and take the time to truly see the world around you.
                     """)
    }

    var HotelsSecondArticle: HotelsArticleViewModel {
        return .init(image: UIImage(named: "ic_article_second")!,
                     description: """
                     Rest is an essential component of a balanced life, and finding moments of tranquility can be particularly rejuvenating when experienced in the luxurious setting of a hotel.
                     A hotel offers a unique sanctuary for rest, where comfort, convenience, and indulgence merge to create an oasis of relaxation. From the moment you step into the lobby, greeted by the friendly faces of hotel staff, you're enveloped in an atmosphere of hospitality designed to cater to your every need.
                     Whether you're traveling for business or pleasure, a hotel provides a respite from the demands of daily life. The plush bedding, soft linens, and serene ambiance of a hotel room invite you to unwind and sink into a state of blissful repose. Here, you can escape the stresses of the outside world and focus on nurturing your mind, body, and spirit.
                     But rest in a hotel goes beyond simply getting a good night's sleep. It's about embracing the luxury of time spent indulging in self-care and pampering. It's about lounging by the pool, sipping cocktails under the sun, and indulging in decadent spa treatments that soothe the soul.
                     Whether you're curled up with a good book in a cozy nook or enjoying a leisurely soak in a deep bathtub, rest in a hotel is a multi-sensory experience that delights the senses and nourishes the spirit.
                     So the next time you're in need of a break from the chaos of everyday life, consider retreating to the serene haven of a hotel. Here, amidst the opulent surroundings and attentive service, you'll find the rest and relaxation you crave, allowing you to return to the world feeling refreshed, rejuvenated, and ready to take on whatever challenges come your way.
                     """)
    }
}
