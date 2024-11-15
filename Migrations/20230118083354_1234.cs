using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebNotes.Migrations
{
    public partial class _1234 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Notes_Customer_CustomerId",
                table: "Notes");

            migrationBuilder.RenameColumn(
                name: "CustomerId",
                table: "Notes",
                newName: "customerId");

            migrationBuilder.RenameIndex(
                name: "IX_Notes_CustomerId",
                table: "Notes",
                newName: "IX_Notes_customerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Notes_Customer_customerId",
                table: "Notes",
                column: "customerId",
                principalTable: "Customer",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Notes_Customer_customerId",
                table: "Notes");

            migrationBuilder.RenameColumn(
                name: "customerId",
                table: "Notes",
                newName: "CustomerId");

            migrationBuilder.RenameIndex(
                name: "IX_Notes_customerId",
                table: "Notes",
                newName: "IX_Notes_CustomerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Notes_Customer_CustomerId",
                table: "Notes",
                column: "CustomerId",
                principalTable: "Customer",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
