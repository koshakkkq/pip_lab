using System.ComponentModel.DataAnnotations;

namespace WebNotes.Models.User;

public class VMUserRegister
{
    [Required(ErrorMessage = "Обязательно для заполнения")]
    [MinLength(8, ErrorMessage = "Введите миниму 8 символов")]
    public string Login { get; set; }
    
    [Required(ErrorMessage = "Обязательно для заполнения")]
    [MinLength(8, ErrorMessage = "Введите минимум 8 символов")]
    public string Password { get; set; }
    
    [Compare("Password", ErrorMessage = "Пароли не совпадают")]
    [MinLength(8, ErrorMessage = "Введите миниму 8 символов")]
    [Required(ErrorMessage = "Обязательно для заполнения")]
    public string ConfirmPassword { get; set; }
}