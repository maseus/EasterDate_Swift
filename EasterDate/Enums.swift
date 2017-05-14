/**
 @file Enums.swift
 @brief Definizione di enumerazioni in uso nell'applicazione.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import Foundation

/**
 @typedef AppTab
 @brief Enumerazione delle Tab dell'applicazione principale.
 @field MAIN_TAB Tab della schermata principale.
 @field INFO_TAB Tab della schermata informativa.
 */
enum AppTab: Int
{
    case MAIN_TAB = 0
    case INFO_TAB = 1
}

/**
 @typedef DeviceLanguage
 @brief Enumerazione delle lingue gestite dall'applicazione.
 @field ITALIAN Italiano.
 @field ENGLISH Inglese.
 */
enum DeviceLanguage: Int
{
    case ITALIAN = 0
    case ENGLISH = 1
}
