//
//  FAQModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct FAQModelElement: Codable, Sendable, Identifiable, Equatable {
    public var id: Int
    public var question: String
    public var answer: String
    
    public init(
        id: Int = .zero,
        question: String = .empty,
        answer: String = .empty
    ) {
        self.id = id
        self.question = question
        self.answer = answer
    }
}

public typealias FAQModel = [FAQModelElement]

// MARK: - Mock
public let mockFAQModel: FAQModel = [
    .init(
        id: 3,
        question: "How many species are discoverted at this time? How many of them are venomous?",
        answer: "There are nearly 3000 species of snakes worldwide, about 600 of them are venomous. In Georgia, there are only 24 species discovered, 9 of them are venomous but only one carries potentially deadly venom - Levantine Viper (also known as Blunt-Nosed Viper)."
    ),
    .init(
        id: 5,
        question: "Are they really as agressive and dangerous as people think? And what to do if encoutered?",
        answer: "Reptiles are shy animals and will always try to avoid conflict, however, like all living creatures, they have a defensive instinct and in case of being attacked, they try to frighten their prey with loud hissing and movements. The cases of biting also happen mainly when trying to follow and/or kill them, therefore, when encoutered, take slow steps back by 2-5 meters and allow them to leave the area."
    ),
    .init(
        id: 6,
        question: "Are there any main differences between venomous and harmless species? How can I identify them?",
        answer: "In general, no. However, due to the fact that venomous species in Georgia are mainly from the family Viperidae, we can distinguish them from the ones from family Colubridae by observing certain details. First of all, the shape of the pupils - vipers in Georgia have cat-like, vertical pupils (unlike Colubrids, which have large and round pupils). They are characterized by a thick, massive body, a short tail and a zigzag pattern on the back. One of the signs is the shape of the triangular head, which is due to the presence of venom glands behind their eyes, although this data is less reliable, since inflating the head for self-defense is also characteristic of non-venomous snakes when defending themselves."
    ),
    .init(
        id: 7,
        question: "What should you do you get bitten?",
        answer: "Although there is only one potentially deadly snake specie in Georgia, you still must observe the bitten area carefully.\nA common sign of a bite from a venomous snake is the presence of one or two puncture wounds from the animal's fangs. Sometimes venom injection from the bite may occur. This may result in redness, swelling, and severe pain at the area, which may take up to an hour to appear.  Vomiting, blurred vision, tingling of the limbs, and sweating may result.\nIf bitten, the first you have to do is to calm down and call 112. It would be better if you take photo of the snake or remember it's color, shape, etc. Person should not be moving/standing during this time, instead they should lay down and move less so low heart rate will prevent venom from spreading quicker.\nIf possible, wash the wound with cold water and soap and apply something cold on it. Person should drink a lots of water and remember, DO NOT tie a bandage above the wound or it will cause necrosis in that area and condition may get worse. Also, do not try to suck out the venom since it won't work and may be dangerous for the one who's sucking it."
    ),
    .init(
        id: 8,
        question: "How to get rid of them?",
        answer: "In general, the main food of snakes is rodents. They spend most of their lives in hiding. Therefore, if we have unwanted reptiles in the yard, one of the ways to get rid of them is to tidy up the yard and make it free of rodents."
    ),
    .init(
        id: 9,
        question: "How effective are electronic devices, or chemicals against them?",
        answer: "None of them are effective against reptiles and can cause much more damage to the human body."
    ),
]
