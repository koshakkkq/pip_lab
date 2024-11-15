using Microsoft.EntityFrameworkCore;
using WebNotes.Data;

namespace WebNotes
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            string connection = builder.Configuration.GetConnectionString("DefaultConnection");
            Console.WriteLine(connection);
            builder.Services.AddDbContext<NotesDbContext>(options => options.UseSqlServer(connection));
            builder.Services.AddControllersWithViews();

            var app = builder.Build();
            builder.Services.AddControllersWithViews();

            using (var scope = app.Services.CreateScope()) {
                var db = scope.ServiceProvider.GetService<NotesDbContext>();
                db.Database.Migrate();
            };

            if (!app.Environment.IsDevelopment())
                {
                    app.UseHsts();
                }

            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthentication();
            app.UseAuthorization();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=LoginScreen}/{action=Main}/{id?}");

            app.Run();
        }
    }
}