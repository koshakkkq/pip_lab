using System.ComponentModel.DataAnnotations;

namespace WebNotes.Models
{
    public class Note
    {
        [Key]
        public int Id { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public DateTime CreatedDate { get; set; }
        public int CountOfChanges { get; set; } = 0;
        public User.User? User { get; set; }
    }
}
