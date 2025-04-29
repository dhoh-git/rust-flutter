use actix_web::{web, HttpResponse, get, Responder};
use sqlx::MySqlPool;
use serde_json::json;
use sqlx::FromRow;
use serde::Serialize;
use serde::Deserialize;
use std::collections::HashMap;


#[derive(FromRow, Serialize, Deserialize)]
pub struct User {
    id:Option<i32>,
    name: Option<String>,
    phone_no:Option<String>,
}


#[get("/api/users")]
async fn get_users(pool: web::Data<MySqlPool>, search: web::Query<HashMap<String, String>>) -> impl Responder {
    let search_string: String = search.get("name").unwrap_or(&String::from("")).clone();

    let condition = if !search_string.is_empty() {
        format!("AND name = {}", search_string)
    } else {
        String::from("AND null")
    };
    
    let query = format!(
        "SELECT id, name, phone_no
        FROM pgs.user
        WHERE 1=1 
        {}",
        condition
    );

    let rows: Result<Vec<User>, _> = sqlx::query_as(&query)
        .fetch_all(pool.as_ref())
        .await;

    match rows {
        Ok(result) => HttpResponse::Ok().json(json!({"data": result })),
        Err(e) => {
            eprintln!("Database error: {:?}", e); 
            HttpResponse::InternalServerError().json(json!({ "message": "Can't find data" }))
        },
    }
}
