using System.ComponentModel.DataAnnotations;

namespace WebNotes.Models.User;

public class VMUserLogin
{
    [Required(ErrorMessage = "Обязательно для заполнения")]
    [MinLength(8, ErrorMessage = "Введите минимум 8 символов")]
    public string Login { get; set; }
    [Required(ErrorMessage = "Обязательно для заполнения")]
    [MinLength(8, ErrorMessage = "Введите минимум 8 символов")]
    public string Password { get; set; }
}