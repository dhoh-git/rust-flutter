extern crate dotenv;
use dotenv::dotenv;

use actix_web::{web, App, HttpServer};
use actix_web::middleware::DefaultHeaders;
use sqlx::mysql::MySqlPoolOptions; //sqlx::MySqlPool;
use std::env;

mod api;
use api::user::{get_user,get_users};


#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    println!("DBURL: {:?}", database_url);

    let pool = MySqlPoolOptions::new().min_connections(3)
        .max_connections(8)
        .connect(&database_url)
        //MySqlPool::connect(&database_url).max_size(5)
        .await
        .expect("Failed to create pool");

    println!("pool size : {}",pool.size());

    let test_query = "SELECT 1";
    match sqlx::query(test_query).execute(&pool).await {
        Ok(_) => println!("Database connected successfully"),
        Err(e) => eprintln!("Failed to connect to database: {:?}", e),
    }

    HttpServer::new(move || {
        App::new()
        .wrap(
            DefaultHeaders::new()
            //.add(("Access-Control-Allow-Origin", "http://0.0.0.0:8081"))
            .add(("Access-Control-Allow-Methods", "GET"))
            .add(("Access-Control-Allow-Headers", "authorization, accept"))
            .add(("Access-Control-Allow-Headers", "content-type"))
            .add(("Access-Control-Max-Age", "3600"))
        )
        .app_data(web::Data::new(pool.clone()))
        //.service(get_users)
        .service(
            web::scope("/api/users")
            .service(get_user)
            .service(get_users)
        )
        
    })
    .bind("0.0.0.0:8081")?
    .run()
    .await
}
