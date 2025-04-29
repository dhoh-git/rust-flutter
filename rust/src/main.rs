extern crate dotenv;
use dotenv::dotenv;

mod api;
use api::user::get_users;
use actix_web::{web, App, HttpServer};
use actix_web::middleware::DefaultHeaders;
use sqlx::MySqlPool;
use std::env;


#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();

    for (key, value) in env::vars() {
        println!("{}: {}", key, value);
    }

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    //let database_url = "mysql://pgs:parkgolf@db:3306/pgs";

    let pool = MySqlPool::connect(&database_url)
        .await
        .expect("Failed to create pool");

    let test_query = "SELECT 1";
    match sqlx::query(test_query).execute(&pool).await {
        Ok(_) => println!("Database connected successfully"),
        Err(e) => eprintln!("Failed to connect to database: {:?}", e),
    }

    HttpServer::new(move || {
        App::new()
    .wrap(
    DefaultHeaders::new()
        .add(("Access-Control-Allow-Origin", "http://0.0.0.0:8081"))
        .add(("Access-Control-Allow-Methods", "GET"))
        .add(("Access-Control-Allow-Headers", "authorization, accept"))
        .add(("Access-Control-Allow-Headers", "content-type"))
        .add(("Access-Control-Max-Age", "3600"))
        )
            .app_data(web::Data::new(pool.clone()))
            .service(get_users)
        
    })
    .bind("0.0.0.0:8081")?
    .run()
    .await
}
