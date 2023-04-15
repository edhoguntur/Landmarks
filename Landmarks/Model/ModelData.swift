//
//  ModelData.swift
//  Landmarks
//
//  Created by Edho Guntur Adhitama on 11/04/23.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    /* Mendeklarasikan variabel landmarks sebagai array dari objek Landmark dan
     menginisialisasinya dengan hasil dari pemanggilan fungsi load dengan argumen
     "landmarkData.json". Fungsi ini bertanggung jawab untuk memuat file JSON dan
     mem-parse-nya menjadi tipe data yang sesuai. */
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks, by: {$0.category.rawValue}
        )
    }
    
}

/* Mendeklarasikan fungsi load yang mengambil argumen filename dengan tipe String
 dan mengembalikan nilai bertipe T, yang harus bisa didekode dengan menggunakan
 protokol Decodable. T di sini adalah generic type, yang nanti akan ditentukan
 berdasarkan tipe data yang dipanggil ketika memanggil fungsi ini. */
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    /* Mencoba untuk mendapatkan URL file yang bernama filename dari bundle utama
     aplikasi. Jika berhasil, maka URL akan disimpan dalam variabel file. Jika
     gagal, maka aplikasi akan keluar dan mencetak pesan error. */
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    /* Mencoba untuk memuat data dari file yang ditemukan sebelumnya menggunakan URL
     file. Jika berhasil, maka data akan disimpan dalam variabel data. Jika gagal,
     maka aplikasi akan keluar dan mencetak pesan error. */
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    /* Mencoba untuk mem-parse data yang sudah dimuat sebelumnya menjadi tipe data
     yang sesuai dengan tipe generic T yang diberikan ketika memanggil fungsi ini.
     Jika berhasil, maka fungsi akan mengembalikan hasil parsing tersebut. Jika
     gagal, maka aplikasi akan keluar dan mencetak pesan error. */
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
