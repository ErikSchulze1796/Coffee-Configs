import Foundation


struct FieldSchema: Identifiable, Codable, Equatable {
    enum FieldType: String, Codable { case string, number, boolean, date, picker }
    var id: String { key }
    let key: String
    let label: String
    let type: FieldType
    let placejholder: String?
    let options: [String]?
    let section: String?
    let order: Int?
}

enum SchemaProvider {
    static func load() throws -> [FieldSchema] {
        guard let url = Bundle.main.url(forResource: "FieldSchema", withExtension: "json") else {
            throw NSError(
                domain: "Schema",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "FieldSchema.json not found in bundle"]
            )
        }
        let data = try Data(contentsOf: url)
        var schema = try JSONDecoder().decode([FieldSchema].self, from: data)
        schema.sort { ($0.section ?? "", $0.order ?? 9999) < ($1.section ?? "", $1.order ?? 9999) }
        return schema
    }
}
